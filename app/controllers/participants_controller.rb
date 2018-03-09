class ParticipantsController < ApplicationController
  before_action :init, only: [:create, :swap]

  def create
    @participant = @seating_plan.participants.new(participant_params)

    @recent_participants = @seating_plan.participants.where(pulse: true)
    @recent_participants.each { |participant| participant.update(pulse: false) }
    @participant.pulse = true if @participant.present?

    @relationship = Relationship.new



    if @participant.save
      @participant.allocate_seat
      redirect_to seating_plan_tables_path(@seating_plan)
      flash[:notice] = "Successfully added your guest : #{@participant.first_name.capitalize} #{@participant.last_name.capitalize}"
    else
      render 'tables/index'
    end
  end

  def update
    @participant = Participant.find(params[:id])
    @seating_plan = @participant.seating_plan
    if @participant.update(participant_params)
      redirect_to seating_plan_tables_path(@seating_plan)
      flash[:notice] = "Successfully updated your guest : #{@participant.first_name.capitalize} #{@participant.last_name.capitalize}"
    else
      render 'tables/index'
    end
  end

  def swap
    @participant = Participant.find(params[:participant_id])
    seat =  params[:seat] == "zone" ? nil : params[:seat].to_i
    @participant.update(seat: seat)

  end

  private

  def participant_params
    params.require(:participant).permit(
      :first_name,
      :last_name,
      :age_range,
      :family_type,
    )
  end
end




