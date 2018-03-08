class SeatingPlansController < ApplicationController
  before_action :init, only: [ :export]

  def create
    @seating_plan = current_user.seating_plans.new(seating_plan_params)
    @seating_plan.default_name

    @seating_plan.define_table_nb
    if @seating_plan.save
      @bride = Participant.create(
        first_name: current_user.bride_first_name,
        last_name: current_user.bride_last_name,
        seating_plan: @seating_plan,
        seat: 1,
        age_range: 2,
        family_type: 1,
        status: 1
        )
      @groom = Participant.create(
        first_name: current_user.groom_first_name,
        last_name: current_user.groom_last_name,
        seating_plan: @seating_plan,
        seat: 2,
        age_range: 2,
        family_type: 0,
        status: 0
        )
      @seating_plan.nb_tables.times do |n|

        @seating_plan.tables.create(name: "Table #{n + 1}", nb_max_participants: @seating_plan.nb_max_participants)
      end
      redirect_to seating_plan_tables_path(@seating_plan)
    else
      flash[:alert] = "Please review your inputs"
      redirect_to root_path
    end
  end

  def show
    #@seating_plan = SeatingPlan.where.not(latitude: nil, longitude: nil)
    @seating_plan = SeatingPlan.find(params[:id])
    @super_tables = SuperTable.new(seating_plan: @seating_plan)

    @marker = [
      {
        lat: @seating_plan.latitude,
        lng: @seating_plan.longitude
      }
    ]
    respond_to do |format|
      format.html
      format.csv { send_data @seating_plan.to_csv }
      format.xls
    end
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

  def export
    respond_to do |format|
      format.html
      format.pdf do
        render pdf: "My_Seating_Plan", footer: { right: '[page] of [topage]' },
               orientation: 'Landscape',
               layout: false,
               margin:  {   top:               5,                     # default 7 (mm)
                            bottom:            5,
                            left:              5,
                            right:             5 }
      end
    end
  end

  private

  def seating_plan_params
    params.require(:seating_plan).permit(:nb_participants, :nb_max_participants, :name, :date, :address)
  end

end
