class PagesController < ApplicationController
  skip_before_action :authenticate_user!, only: [:home]

  def home
    @seating_plan = SeatingPlan.new
  end

end
