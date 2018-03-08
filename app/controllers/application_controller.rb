class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  before_action :authenticate_user!

  def configure_permitted_parameters
    # For additional fields in app/views/devise/registrations/new.html.erb
    devise_parameter_sanitizer.permit(:sign_up, keys: [:bride_first_name, :bride_last_name, :groom_first_name, :groom_last_name, :address])
  end

  def init
    # @seating_plan = SeatingPlan.includes(:participants).find(params[:seating_plan_id].to_i)
    @seating_plan = SeatingPlan.find(params[:seating_plan_id].to_i)
    @bride = @seating_plan.participants.find_by(seat: 1)
    @groom = @seating_plan.participants.find_by(seat: 2)
    @first_guest = Participant.new
    @second_guest = Participant.new
    @tables = @seating_plan.tables.order(:id)
    @super_tables = SuperTable.new(seating_plan: @seating_plan).list
  end

end
