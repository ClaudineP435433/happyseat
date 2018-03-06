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

  enum family_type: { groom: 0, bride: 1, others: 2 }

  accepts_nested_attributes_for :relationships, reject_if: proc { |attributes| attributes[:link].blank? && attributes[:second_guest_id].blank? }, allow_destroy: true


  def name
      "#{first_name} #{last_name}"
  end

  def initial
    "#{first_name[0].capitalize}#{last_name[0].capitalize}"
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
    self.relationships.find_by(link: "couple").present?
  end

  def couple_not_separated
    if couple?
      my_husband = Relationship.find_by(link: "couple", first_guest: self).second_guest
      #si nouvel table de self dispo alors on place aussi le conjoint dessus
      #si pas de place dispo alors recherche d'une nouvelle table avec 2 siéges et pas la table du ou des mecs qu'ils aiment pas
      table_index = super_tables.find_table(self.first_guest.seat)
      second_guest_seat = super_tables.find_available_seat(table_index)
      second_guest_seat = super_tables.first_seat_available if second_guest_seat.nil?
      self.second_guest.update(seat: second_guest_seat)
    end
  end

end
