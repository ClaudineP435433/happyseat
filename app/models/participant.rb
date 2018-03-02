class Participant < ApplicationRecord
  belongs_to :table
  #has_many :relationships
  has_many :relationships, inverse_of: :first_guest
  has_many :relationships, inverse_of: :second_guest

  validates :first_name, presence: true
  validates :last_name, presence: true
  #validates :seat, uniqueness: { scope: :table_id }
  validates :age_range, presence: true

  enum age_range: { children: 0, teenagers: 1, adults: 2, elderly: 3 }

  enum family_type: { groom: 0, bride: 1, others: 2 }

  accepts_nested_attributes_for :relationships, reject_if: proc { |attributes| attributes[:link].blank? && attributes[:second_guest_id].blank? }, allow_destroy: true


  def name
      "#{first_name} #{last_name}"
  end


  def name
    "#{first_name} #{last_name}"
  end

  def initial
    "#{first_name[0].capitalize}#{last_name[0].capitalize}"
  end
end
