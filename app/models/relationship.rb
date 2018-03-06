class Relationship < ApplicationRecord
  belongs_to :first_guest, class_name: 'Participant', foreign_key: 'first_guest_id', inverse_of: :relationships
  belongs_to :second_guest, class_name: 'Participant', foreign_key: 'second_guest_id', inverse_of: :relationships


  validates :first_guest, uniqueness: { scope: :second_guest }
  validates :link, presence: true
  validates :first_guest, presence: true
  validates :second_guest, presence: true
  enum link: { couple: 0, hate: 1 }

  accepts_nested_attributes_for :first_guest, reject_if: proc { |attributes| attributes[:first_name].blank? && attributes[:last_name].blank? && attributes[:age_range].blank? && attributes[:family_type].blank? }, allow_destroy: true
  accepts_nested_attributes_for :second_guest, reject_if: proc { |attributes| attributes[:first_name].blank? && attributes[:last_name].blank? && attributes[:age_range].blank? && attributes[:family_type].blank? }, allow_destroy: true

  # after_create :recipro

  # def recipro
  #   Relationship.create(participant: self.second_guest ,second_guest: participant)
  # end

  def errors_flash
    if self.link == "couple"
      "Successfully added your guests in couple"
    elsif self.link == "hate"
      "Successfully added your conflictual relationship"
    else
      "Error in your last update"
    end
  end

  def reverse_relationship
    Relationship.create(first_guest: second_guest, second_guest: first_guest, link: link)
  end

  def love_seat(seating_plan)

    super_tables = SuperTable.new(seating_plan: seating_plan)
    # Besoin de tous les relationships du seating plan
    # relationships = seating_plan.relationships.where(link: "couple")
    # on itére sur chaque relationship
    # relationships.each do |relation|

      if self.first_guest.seat.present? && self.second_guest.seat.nil?
        table_index = super_tables.find_table(self.first_guest.seat)
        second_guest_seat = super_tables.find_available_seat(table_index)
        second_guest_seat = super_tables.first_seat_available if second_guest_seat.nil?
        self.second_guest.update(seat: second_guest_seat)
      elsif self.second_guest.seat.present? && self.first_guest.seat.nil?
        table_index = super_tables.find_table(self.second_guest.seat)
        first_guest_seat = super_tables.find_available_seat(table_index)
        first_guest_seat = super_tables.first_seat_available if first_guest_seat.nil?
        self.first_guest.update(seat: first_guest_seat)
      elsif self.second_guest.seat.nil? && self.first_guest.seat.nil?
        table_index = super_tables.find_table_with_two_available_seats
        seats_available = super_tables.find_two_seats(table_index)
        first_guest_seat = seats_available.first[:seat_id]
        self.first_guest.update(seat: first_guest_seat)
        second_guest_seat = seats_available.second[:seat_id]
        self.second_guest.update(seat: second_guest_seat)
      end
    # end
  end


  def hate_seat(seating_plan)
    super_tables = SuperTable.new(seating_plan: seating_plan)
    if super_tables.find_table(self.first_guest.seat) == super_tables.find_table(self.second_guest.seat)
      if first_guest.couple_relationships.size >= second_guest.couple_relationships.size
        #si first en couple
        switch_guests(super_tables, first_guest, second_guest)
      else
        switch_guests(super_tables, second_guest, first_guest)
      end
    end
  end

  def switch_guests(super_tables, guest_1, guest_2)
    # table_index = super_tables.find_table(guest_1.seat)
    # second_table_index = super_tables.find_another_table(table_index)
    # guest_2_seat = super_tables.find_available_seat(second_table_index)
    # guest_2.update(seat: guest_2_seat)
    score_guest_2 = super_tables.score_table(guest_2) #renvoie [{table_index: 0,score: 1 }, {}] avec toutes les tables
    score_guest_2_sorted = score_guest_2.select { |table| super_tables.table_available(table[:table_index]) }.sort { |table| table[:score] }
    guest_2_table = score_guest_2_sorted.first[:table_index]
    guest_2_seat = super_tables.find_available_seat(guest_2_table)
    guest_2.update(seat: guest_2_seat)
  end

end
