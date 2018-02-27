class Relationship < ApplicationRecord
  belongs_to :first_guest, class_name: 'Participant', foreign_key: 'first_guest_id'
  belongs_to :second_guest, class_name: 'Participant', foreign_key: 'second_guest_id'

  validates :first_guest, uniqueness: { scope: :second_guest }
  validates :link, presence: true
  validates :first_guest, presence: true
  validates :second_guest, presence: true
  enum link: { couple: 0, hate: 1 }

  # after_create :recipro

  # def recipro
  #   Relationship.create(first_guest: self.second_guest ,second_guest: first_guest)
  # end
end
