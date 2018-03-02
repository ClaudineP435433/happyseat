class TablesController < ApplicationController
  def index
    @seating_plan = SeatingPlan.find(params[:seating_plan_id])
    @tables = @seating_plan.tables
    @nbhaut = @tables.first.nb_max_participants/2.round
    @nbbas = @tables.first.nb_max_participants - @nbhaut

    @participant = Participant.new
    @first_guest = Participant.new
    @second_guest = Participant.new
    @relationship = Relationship.new

    @participants = Participant.all
  end

  def find_for_modal
    @participant = Participant.find(search_params[:participant_id])
    respond_to do |format|
      format.html { redirect_to seating_plan_tables_path(search_params[:seating_plan_id]) }
      format.js
    end
  end



private

  def search_params
    params.require(:search).permit(
      :participant_id,
      :seating_plan_id
      )
  end

end
