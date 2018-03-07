class Participant < ApplicationRecord
  belongs_to :seating_plan
  #has_many :relationships
  has_many :relationships, inverse_of: :first_guest
  has_many :relationships, inverse_of: :second_guest


  validates :first_name, presence: true
  validates :last_name, presence: true
  #validates :seat, uniqueness: { scope: :table_id }
  validates :age_range, presence: true

  enum age_range: { children: 0, teenagers: 1, adults: 2, elderly: 3 }
  enum status: { g: 0, b: 1, o: 2}
  enum family_type: { groom: 0, bride: 1, others: 2 }

  accepts_nested_attributes_for :relationships, reject_if: proc { |attributes| attributes[:link].blank? && attributes[:second_guest_id].blank? }, allow_destroy: true


  def name
      "#{first_name.capitalize} #{last_name.capitalize}"
  end

  def initial
    "#{first_name[0].capitalize}#{last_name[0].capitalize}"
  end

  def decoration_name
      "#{first_name.capitalize} #{last_name[0].capitalize}."
  end

  def allocate_seat
    super_tables = SuperTable.new(seating_plan: seating_plan)
    participant_seat = super_tables.first_seat_available
    self.update(seat: participant_seat)
  end

  def couple_relationships
    if couple?
      my_husband = Relationship.find_by(link: "couple", first_guest: self).second_guest
      Relationship.where(link: "hate", first_guest_id: [my_husband.id, self.id])
    else
      Relationship.where(link: "hate", first_guest: self)
    end
  end

  def couple?
    Relationship.where(link: "couple", first_guest: self).present?
    #self.relationships.find_by(link: "couple").present?
  end

  # def couple_not_separated
  #   if couple?
  #     super_tables = SuperTable.new(seating_plan: seating_plan)
  #     table_index = super_tables.find_table(self.seat)
  #     my_husband = Relationship.find_by(link: "couple", first_guest: self).second_guest
  #     #si nouvel table de self dispo alors on place aussi le conjoint dessus
  #     if (super_tables.table_available(table_index))
  #       second_guest_seat = super_tables.find_available_seat(table_index)
  #       my_husband.update(seat: second_guest_seat)
  #     else
  #       new_table_index = super_tables.find_table_with_two_available_seats_with_no_hate_people(couple_relationships)
  #       seats_available = super_tables.find_two_seats(new_table_index)
  #       first_guest_seat = seats_available.first[:seat_id]
  #       self.first_guest.update(seat: first_guest_seat)
  #       second_guest_seat = seats_available.second[:seat_id]
  #       self.second_guest.update(seat: second_guest_seat)
  #     #si pas de place dispo alors recherche d'une nouvelle table avec 2 siéges et pas la table du ou des mecs qu'ils aiment pas
  #     end
  #   end
  # end

end
