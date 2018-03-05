class TablesController < ApplicationController
  before_action :init, only: [:index]

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

private

  def search_params
    params.require(:search).permit(
      :participant_id,
      :seating_plan_id
      )
  end

end
