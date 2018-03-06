module ApplicationHelper

  def avatar_colored(seat_id)
    seat = @seating_plan.participants.find_by(seat: seat_id)
    if seat.present?
      if seat.family_type == "bride"
        "avatar_pink"
      elsif seat.family_type == "groom"
        "avatar_blue"
      else
        "avatar_color"
      end
    end
  end
end
