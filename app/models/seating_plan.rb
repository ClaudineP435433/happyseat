class SeatingPlan < ApplicationRecord
  belongs_to :user
  has_many :tables
  has_many :participants, through: :tables
  validates :nb_participants, presence: true

  def default_name
    "My Seating Plan" if name.nil?
  end
end
