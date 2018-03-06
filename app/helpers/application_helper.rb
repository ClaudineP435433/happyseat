module ApplicationHelper

  def avatar_colored(seat_id)
    participant = @seating_plan.participants.find_by(seat: seat_id)
    if participant.present?
      if participant.status == "b"
        "avatar_bride avatar_pink"
      elsif participant.status == "g"
        "avatar_groom avatar_blue"
      elsif participant.family_type == "bride"
        "avatar_pink"
      elsif participant.family_type == "groom"
        "avatar_blue"
      else
        "avatar_color"
      end
    end
  end
end
