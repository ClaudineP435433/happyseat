class Relationship < ApplicationRecord
  belongs_to :participant, inverse_of: :relationships
  belongs_to :second_guest, class_name: 'Participant', foreign_key: 'second_guest_id'

  validates :participant, uniqueness: { scope: :second_guest }
  validates :link, presence: true
  validates :participant, presence: true
  validates :second_guest, presence: true
  enum link: { couple: 0, hate: 1 }

  # after_create :recipro

  # def recipro
  #   Relationship.create(participant: self.second_guest ,second_guest: participant)
  # end
end
