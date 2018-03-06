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
      redirect_to seating_plan_tables_path(@seating_plan)
    else
      flash[:alert] = "Please review your inputs"
      redirect_to root_path
    end
  end

  def show
    @seating_plan = SeatingPlan.find(params[:id])
    @seating_plans = SeatingPlan.where.not(latitude: nil, longitude: nil)
    @marker = [
      {
        lat: @seating_plan.latitude,
        lng: @seating_plan.longitude
      }
    ]
  end

  def update
    @seating_plan = SeatingPlan.find(params[:id])
    if @seating_plan.update(seating_plan_params)
      flash[:notice] = 'Successfully updated your wedding details'
      redirect_to seating_plan_path(@seating_plan)
    else
      render 'seating_plan/show'
    end
  end

  private

  def seating_plan_params
    params.require(:seating_plan).permit(:nb_participants, :nb_max_participants, :nb_tables, :name, :date, :address)
  end

end
