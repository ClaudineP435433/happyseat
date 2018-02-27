class Table < ApplicationRecord
  belongs_to :seating_plan
  has_many :participants
  # enum status: { empty: 0, available: 1, full: 2 }
  #validates :nb_max_participants, presence: true

  def default_nb_max_participants
    return nb_max_participants if nb_max_participants.present?
    seating_plan.nb_max_participants
  end
end
