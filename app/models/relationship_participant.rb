class RelationshipParticipant < ApplicationRecord
  belongs_to :participant
  belongs_to :relationship
  validates :participant_id, presence: true
  validates :relationship_id, presence: true
end
