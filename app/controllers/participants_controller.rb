class ParticipantsController < ApplicationController

  def create
    @seating_plan = SeatingPlan.find(params[:seating_plan_id].to_i)
    @table = @seating_plan.tables.first
    @participant = Participant.new(participant_params)
    @participant.table = @table
    # @participant.seat = 4 #algo
    if @participant.save
      redirect_to seating_plan_tables_path(@seating_plan)
      #algo ajouter sur table + allouer un siége
      flash[:notice] = "Successfully added your guest : #{@participant.first_name.capitalize} #{@participant.last_name.capitalize}"
    else
      @tables = Table.all
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




