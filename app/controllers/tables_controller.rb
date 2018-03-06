class TablesController < ApplicationController
  before_action :init, only: [:index, :update]

  def index
    @relationship = Relationship.new
    @participant = Participant.new
    @participants = Participant.all
  end

  def find_for_modal
    @participant = Participant.find(search_params[:participant_id])
    @relationship = Relationship.new
    respond_to do |format|
      format.html { redirect_to seating_plan_tables_path(search_params[:seating_plan_id]) }
      format.js
    end
  end

  # def edit
  # end

  def update
    @table = Table.find(params[:id])
    if @table.update(tables_params)
      flash[:notice] = 'Successfully updated your table name'
      redirect_to seating_plan_tables_path(@seating_plan)
    else
      render 'tables/index'
    end
  end


private

  def search_params
    params.require(:search).permit(
      :participant_id,
      :seating_plan_id
      )
  end

  def tables_params
    params.require(:table).permit(:name)
  end

end
