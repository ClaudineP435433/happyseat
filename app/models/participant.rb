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
    score_by_age = super_tables.select_available_table_by_age(1, self)
    self.seat_allocation(super_tables, score_by_age)
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
  end

  def my_husband
    if couple?
      Relationship.find_by(link: "couple", first_guest: self).second_guest
    end
  end

  def seat_allocation(super_tables, table_ids)
    guest_table = table_ids.first[:table_index]
    seats_available = super_tables.find_seats(guest_table)
    guest_seat = seats_available.first[:seat_id]
    self.update(seat: guest_seat)
    if self.couple?
      my_husband_seat = seats_available.second[:seat_id]
      self.my_husband.update(seat: my_husband_seat)
    end
  end

  def table_nb
    super_tables = SuperTable.new(seating_plan: self.seating_plan)
    table_index = super_tables.find_table(self.seat)
    if table_index.nil?
      return ""
    else
      self.seating_plan.tables.order(:id)[table_index].name
    end
  end

end
