class RelationshipsController < ApplicationController
  before_action :init, only: [:create]

  def create
    @relationship = Relationship.new(relationship_params)
    @participant = Participant.new
    @table = @seating_plan.tables.first
    #@participant.table = @table ATTENTION allouer une table au M et Mme ;)

    @relationship.first_guest.table = @table if @relationship.first_guest.present?
    @relationship.second_guest.table = @table if @relationship.second_guest.present?

    if @relationship.save
      redirect_to seating_plan_tables_path(@table.seating_plan)
      flash[:notice] = @relationship.errors_flash
      #algo ajouter sur table + allouer un siége
    else
      flash[:alert] = "Please review your inputs"
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
