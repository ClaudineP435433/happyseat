class TablesController < ApplicationController
  def index
    @seating_plan = SeatingPlan.find(params[:seating_plan_id])
    @tables = @seating_plan.tables
    @seats = (1..@seating_plan.nb_participants).to_a
    #@seats = [1,2,3,...,100]

    @super_tables = {}
    @tables.each_with_index do |table, index|
      @super_tables["#{index}"] = @seats[0..table.nb_max_participants-1]
      @seats = @seats[table.nb_max_participants..-1]
    end

    # avatar en haut et en bas
    # @nbhaut = @tables.first.nb_max_participants/2.round
    # @nbbas = @tables.first.nb_max_participants - @nbhaut

    @participant = Participant.new
    @first_guest = Participant.new
    @second_guest = Participant.new
    @relationship = Relationship.new

    @participants = Participant.all

    if params[:query].present?
      sql_query = " \
      participants.first_name @@ :query \
      OR participants.last_name @@ :query \
      "
      raise
      @participant_search = Participant.where(sql_query, query: "%#{params[:query]}%")
    end
  end

  def update
  end
end
