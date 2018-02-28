class TablesController < ApplicationController
  def index
    @seating_plan = SeatingPlan.find(params[:seating_plan_id])
    @tables = @seating_plan.tables
    @nbhaut = @tables.first.nb_max_participants/2.round
    @nbbas = @tables.first.nb_max_participants - @nbhaut


    @participant = Participant.new
    @participant2 = Participant.new
  end

  def update
  end
end
