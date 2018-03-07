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

  def table_availables
    @list.select.with_index { |table, index| table_available(index)}
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
    #ATTENTION SI TROP GENS CA CASSE!!!! T'es dans la merde!!
  end

  def find_two_seats(index)
    @list[index].select { |seat| seat[:participant_id].nil?}
  end

  def find_another_table(table_index)
    @list.each_with_index do |table, index|
      return index if table.select { |seat| seat[:participant_id].nil?}.any? && index != table_index
    end
  end

  def score_table(guest)
    relationships_list = guest.couple_relationships
    seats_list = relationships_list.map {|relation| relation.second_guest.seat}
    @list.map.with_index do |table, index|
      {table_index: index,
       score: table.count{ |seat| seats_list.include? seat[:seat_id]}}
    end
  end

end
