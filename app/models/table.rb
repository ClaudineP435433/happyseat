class Table < ApplicationRecord
  belongs_to :seating_plan
  has_many :participants
  # enum status: { empty: 0, available: 1, full: 2 }
  validates :nb_max_participants, presence: true
end
