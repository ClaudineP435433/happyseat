class RelationshipsController < ApplicationController
  def create
    @seating_plan = SeatingPlan.find(params[:seating_plan_id].to_i)
    @table = @seating_plan.tables.first
    @relationship = Relationship.new(relationship_params)
    #@relationship.link = 0
    #@participant.table = @table ATTENTION allouer une table au M et Mme ;)
    @relationship.first_guest.table = @table
    @relationship.second_guest.table = @table

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
