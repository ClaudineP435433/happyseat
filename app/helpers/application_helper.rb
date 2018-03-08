module ApplicationHelper

  def avatar_family(seat_id)
    participant = @seating_plan.participants.find_by(seat: seat_id)
    if participant.present?
      if participant.family_type == "bride"
        "avatar_pink_test"
      elsif participant.family_type == "groom"
        "avatar_blue_test"
      else
        "avatar_color_test"
      end
    end
  end

  def avatar_colored(seat_id)
    participant = @seating_plan.participants.find_by(seat: seat_id)
    if participant.present?
      if participant.status == "b"
        c = "avatar_bride avatar_pink"
      elsif participant.status == "g"
        c = "avatar_groom avatar_blue"
      elsif participant.age_range == "children"
        c = "avatar_age avatar_children"
      elsif participant.age_range == "elderly"
        c = "avatar_age avatar_elderly"
      elsif participant.age_range == "adults"
        c = "avatar_age avatar_adults"
      elsif participant.age_range == "teenagers"
        c = "avatar_age avatar_teenagers"
      else
        c = "avatar_color"
      end
      participant.pulse ? "#{c} pulse-button" : c
    end

  end
end
