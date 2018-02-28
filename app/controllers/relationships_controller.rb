class RelationshipsController < ApplicationController
  def create
    @table = Table.first
    @relationship = Relationship.new(relationship_params)
    @relationship.link = 0
    #@participant.table = @table ATTENTION allouer une table au M et Mme ;)
    @relationship.first_guest.table = Table.first
    @relationship.second_guest.table = Table.first

    if @relationship.save
      redirect_to seating_plan_tables_path(@table.seating_plan)
      flash[:notice] = "Successfully added your guests in couple"
      #algo ajouter sur table + allouer un siége
    else
      @tables = Table.all
      render 'tables/index'
    end
  end

  private

  def relationship_params
    params.require(:relationship).permit(
      :link,
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
