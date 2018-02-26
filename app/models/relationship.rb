class Relationship < ApplicationRecord
  has_many :relationship_participants, dependent: :destroy
  validates :link, presence: true
  enum link: { couple: 0, hate: 1 }
  validate :validate_number_participant

  def validate_number_participant
    errors.add(:relationship_participants, "too much") if relationship_participants.size > 2
  end

end
