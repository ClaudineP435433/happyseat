class Relationship < ApplicationRecord
  belongs_to :first_guest, class_name: 'Participant', foreign_key: 'first_guest_id', inverse_of: :relationships
  belongs_to :second_guest, class_name: 'Participant', foreign_key: 'second_guest_id', inverse_of: :relationships

  validates :first_guest, uniqueness: { scope: :second_guest }
  validates :link, presence: true
  validates :first_guest, presence: true
  validates :second_guest, presence: true
  enum link: { couple: 0, hate: 1 }

  accepts_nested_attributes_for :first_guest, reject_if: proc { |atrributes| atrributes[:first_name].blank? && atrributes[:last_name].blank? && atrributes[:age_range].blank? && atrributes[:family_type].blank? }, allow_destroy: true
  accepts_nested_attributes_for :second_guest, reject_if: proc { |atrributes| atrributes[:first_name].blank? && atrributes[:last_name].blank? && atrributes[:age_range].blank? && atrributes[:family_type].blank? }, allow_destroy: true

  # after_create :recipro

  # def recipro
  #   Relationship.create(participant: self.second_guest ,second_guest: participant)
  # end
end
