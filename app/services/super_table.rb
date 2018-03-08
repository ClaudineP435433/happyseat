class SuperTable

  attr_accessor :list

  def initialize(params = {})
    @seating_plan = params[:seating_plan]
    create_list
  end

  def create_list
    seats = (1..@seating_plan.nb_participants).to_a.map do |s|
      participant = @seating_plan.participants.find_by(seat: s)
      {
        seat_id: s,
        participant_id: (participant.id if participant),
        participant_age: (participant.read_attribute_before_type_cast(:age_range) if participant),
        name:(participant.name if participant)
        initials: (participant.initial  if participant)
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

  def table_empty(index)
    @list[index].select { |seat| seat[:participant_id].present?}.empty?
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
    #si nil, 2 individuel
    #ATTENTION SI TROP GENS CA CASSE!!!! T'es dans la merde!!
  end

  def find_two_seats(index)
    @list[index].select { |seat| seat[:participant_id].nil?}
  end

  def find_seats(index)
    @list[index].select { |seat| seat[:participant_id].nil?}
  end

  def find_another_table(table_index)
    @list.each_with_index do |table, index|
      return index if table.select { |seat| seat[:participant_id].nil?}.any? && index != table_index
    end
  end

  def score_relationship(guest)
    relationships_list = guest.couple_relationships
    seats_list = relationships_list.map {|relation| relation.second_guest.seat}
    @list.map.with_index do |table, index|
      {table_index: index,
       score: table.count{ |seat| seats_list.include? seat[:seat_id]}
      }
    end
  end

  def select_available_table_by_relationship(nb_available_seats, guest)
    tables = self.score_relationship(guest).select do |table|
      self.find_seats(table[:table_index]).size >= nb_available_seats
    end
    tables.sort { |table| table[:score] }
  end

  def score_age
    @list.map.with_index do |table, index|
      ages = table.map { |seat| seat[:participant_age] }.compact
      significant_age = ages.compact
                            .group_by { |i| i}
                            .sort_by{|k,v| k}
                            .sort_by{ |t| t[1].size}
                            .flatten
                            .last
      {
        table_index: index,
        score: significant_age
      }
    end
  end

  def select_available_table_by_age(nb_available_seats, guest)
    tables = self.score_age.select do |table|
      self.find_seats(table[:table_index]).size >= nb_available_seats
    end
    guest_age = guest.read_attribute_before_type_cast(:age_range)
    table_same_age = tables.select { |table| table[:score] == guest_age}
    return table_same_age if table_same_age.present?
    table_without_guest = tables.select { |table| table[:score] == nil }
    return table_without_guest if table_without_guest.present?
    tables
  end


end
