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
  end

  def export
    respond_to do |format|
      format.html
      format.pdf do
        render pdf: "My Seating Plan",
               template: 'seating_plans/export.html.erb',
               orientation: 'Landscape',
               layout: 'pdf',
               margin:  {   top:               15,                     # default 10 (mm)
                            bottom:            15,
                            left:              15,
                            right:             15 }
      end
    end
  end

  private

  def seating_plan_params
    params.require(:seating_plan).permit(:nb_participants, :nb_max_participants, :nb_tables)
  end

end
