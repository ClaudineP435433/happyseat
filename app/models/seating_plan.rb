class SeatingPlan < ApplicationRecord
  belongs_to :user
  has_many :tables
  has_many :participants, through: :tables
  validates :nb_participants, presence: true
  validates :nb_max_participants, presence: true
  validates :nb_tables, presence: true

  def default_name
    "My Seating Plan" if name.nil?
  end

  def super_tables
    seats = (1..self.nb_participants).to_a
    super_tables = {}
    self.tables.each_with_index do |table, index|
      super_tables["#{index}"] = seats[0..table.nb_max_participants-1]
      seats = seats[table.nb_max_participants..-1]
    end
    super_tables
  end
end
