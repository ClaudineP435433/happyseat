class SeatingPlansController < ApplicationController

  def create
    @seating_plan = current_user.seating_plans.new(seating_plan_params)
    if @seating_plan.save
      redirect_to root_path
    else
      render "pages/new"
    end
  end

  private

  def seating_plan_params
    params.require(:seating_plan).permit(:nb_participants, :nb_max_participants, :nb_tables)
  end
end
