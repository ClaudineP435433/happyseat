class TablesController < ApplicationController
  def index
    @tables = Table.all
    @nbhaut = @tables.first.nb_max_participants/2.round
    @nbbas = @tables.first.nb_max_participants - @nbhaut
  end

  def update
  end
end
