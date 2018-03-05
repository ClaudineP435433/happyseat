class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  before_action :authenticate_user!

  def configure_permitted_parameters
    # For additional fields in app/views/devise/registrations/new.html.erb
    devise_parameter_sanitizer.permit(:sign_up, keys: [:bride_first_name, :bride_last_name, :groom_first_name, :groom_last_name, :address])
  end

  def init
    @seating_plan = SeatingPlan.find(params[:seating_plan_id].to_i)
    @first_guest = Participant.new
    @second_guest = Participant.new
    @tables = @seating_plan.tables
    @super_tables = @seating_plan.super_tables
  end

end
