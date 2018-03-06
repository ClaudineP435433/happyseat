class SuperTable

  attr_accessor :list

  def initialize(params = {})
    @seating_plan = params[:seating_plan]
    create_list
  end

  def create_list
    seats = (1..@seating_plan.nb_participants).to_a.map do |s|
      {
        seat_id: s,
        participant_id: (Participant.find_by(seat: s).id if Participant.find_by(seat: s))
      }
    end
    @list = seats.in_groups_of(@seating_plan.nb_max_participants, false)
  end

  def find_table(s)
    @list.each_with_index do |table, index|
      return index if table.map{|seat| seat[:seat_id]}.include? s
    end
    nil
  end

  def table_available(index)
    #renvoie true place
    @list[index].select { |seat| seat[:participant_id].nil?}.any?
  end

  def find_available_seat(index)
    #renvoie true place
    @list[index].find { |seat| seat[:participant_id].nil?}[:seat_id]
  end

  def first_seat_available
    @list.flatten.find { |seat| seat[:participant_id].nil?}[:seat_id]
  end

  def find_table_with_two_available_seats
    @list.each_with_index do |table, index|
      return index if table.select { |seat| seat[:participant_id].nil?}.size >= 2
    end
    nil
    #ATTENTION SI TROP GENS CA CASSE!!!! T'es dans la merde
  end

  def find_table_with_two_available_seats_with_no_hate_people(couple_relationships)
    @list.each_with_index do |table, index|
      two_seats = table.select { |seat| seat[:participant_id].nil?}.size >= 2
      hate_pers = couple_relationships.map { |relation| relation.second_guest.id }
      no_hate_pers = table.select { |seat| !hate_pers.include? seat[:participant_id] }
      if (two_seats) && (no_hate_pers)
        return index
      end
    end
    nil
  end

  def find_two_seats(index)
    @list[index].select { |seat| seat[:participant_id].nil?}
  end

  def find_another_table(table_index)
    @list.each_with_index do |table, index|
      return index if table.select { |seat| seat[:participant_id].nil?}.any? && index != table_index
    end
  end

end
