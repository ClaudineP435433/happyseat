class SeatingPlansController < ApplicationController

  def create
    @seating_plan = current_user.seating_plans.new(seating_plan_params)
    @seating_plan.default_name

    n = 1

    if @seating_plan.save
      params[:seating_plan][:nb_tables].to_i.times do
        @seating_plan.tables.create(name: "Table #{n}", nb_max_participants: params[:seating_plan][:nb_max_participants])
        n += 1
      end
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
