class RelationshipParticipant < ApplicationRecord
  belongs_to :participant
  belongs_to :relationship
end
