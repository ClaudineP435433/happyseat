class RelationshipsController < ApplicationController
  def create
    @table = Table.first
    @relationship = Relationship.new(relationship_params)
    #@relationship.link = 0
    #@participant.table = @table ATTENTION allouer une table au M et Mme ;)
    @relationship.first_guest.table = Table.first
    @relationship.second_guest.table = Table.first

    if @relationship.save
      redirect_to seating_plan_tables_path(@table.seating_plan)
      if @relationship.link == "couple"
        flash[:notice] = "Successfully added your guests in couple"
      elsif @relationship.link == "hate"
        flash[:notice] = "Successfully added your conflictual relationship"
      else
        flash[:notice] = "Error in your last update"
      end
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
