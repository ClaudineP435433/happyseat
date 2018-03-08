class RelationshipsController < ApplicationController
  before_action :init, only: [:create]

  def create

    @relationship = Relationship.new(relationship_params)
    @participant = @seating_plan.participants.new

    @recent_participants = @seating_plan.participants.where(pulse: true)
    @recent_participants.each { |participant| participant.update(pulse: false) }
    @relationship.first_guest.pulse = true if @relationship.first_guest.present?
    @relationship.second_guest.pulse = true if @relationship.second_guest.present?

    @relationship.first_guest.seating_plan = @seating_plan if @relationship.first_guest.present?
    @relationship.second_guest.seating_plan = @seating_plan if @relationship.second_guest.present?

    if @relationship.save
      @relationship.reverse_relationship
      @relationship.love_seat(@seating_plan) if @relationship.link == "couple"
      @relationship.hate_seat(@seating_plan) if @relationship.link == "hate"
      flash[:notice] = @relationship.errors_flash
      redirect_to seating_plan_tables_path(@seating_plan)
      flash.now[:notice] = @relationship.errors_flash
    else
      flash.now[:alert] = "Please review your inputs"
      render 'tables/index'
    end
  end


  private

  def relationship_params
    params.require(:relationship).permit(
      :link,
      :first_guest_id,
      :second_guest_id,
      first_guest_attributes: [
          :first_name,
          :last_name,
          :age_range,
          :family_type
        ],
      second_guest_attributes: [
          :first_name,
          :last_name,
          :age_range,
          :family_type
        ]
    )
  end

end
