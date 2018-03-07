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
        "avatar_bride avatar_pink"
      elsif participant.status == "g"
        "avatar_groom avatar_blue"
      elsif participant.age_range == "children"
        "avatar_children"
      elsif participant.age_range == "elderly"
        "avatar_elderly"
      elsif participant.age_range == "adults"
        "avatar_adults"
      elsif participant.age_range == "teenagers"
        "avatar_teenagers"
      else
        "avatar_color"
      end
    end
  end
end
