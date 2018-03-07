class SeatingPlan < ApplicationRecord
  belongs_to :user
  has_many :tables
  has_many :participants
  has_many :relationships, through: :participants
  validates :nb_participants, presence: true
  validates :nb_max_participants, presence: true
  validates :nb_tables, presence: true

  geocoded_by :address
  after_validation :geocode, if: :will_save_change_to_address?

  def default_name
    "My Seating Plan" if name.nil?
  end


end
