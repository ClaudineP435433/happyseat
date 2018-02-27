class TablesController < ApplicationController
  def index
    @tables = Table.all
    @nbhaut = @tables.first.nb_max_participants/2.round
    @nbbas = @tables.first.nb_max_participants - @nbhaut

    @participant = Participant.new
    @participant2 = Participant.new
    @relationship = Relationship.new
  end

  def update
  end
end
