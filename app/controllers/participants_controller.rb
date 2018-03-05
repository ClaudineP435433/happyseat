class ParticipantsController < ApplicationController
  before_action :init, only: [:create]

  def create
    @participant = @seating_plan.participants.new(participant_params)
    @relationship = Relationship.new
    if @participant.save
      redirect_to seating_plan_tables_path(@seating_plan)
      #algo ajouter sur table + allouer un siége
      flash[:notice] = "Successfully added your guest : #{@participant.first_name.capitalize} #{@participant.last_name.capitalize}"
    else
      render 'tables/index'
    end
  end

  def update
    @participant = Participant.find(params[:id])
    if @participant.update(participant_params)
      flash[:notice] = 'Successfully updated participant'
      redirect_to seating_plan_tables_path(@seating_plan)
    else
      render 'tables/index'
    end
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




