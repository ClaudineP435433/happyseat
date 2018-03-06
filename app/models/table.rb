class Table < ApplicationRecord
  belongs_to :seating_plan
  has_many :participants, through: :seating_plan
  #enum status: { empty: 0, available: 1, full: 2 }
  #validates :nb_max_participants, presence: true

  def default_nb_max_participants
    return nb_max_participants if nb_max_participants.present?
    seating_plan.nb_max_participants
  end

  # def default_status
  #   return :empty if self.participants == 0
  #   return :full if self.participants >= nb_max_participants
  #   :available
  # end
end
