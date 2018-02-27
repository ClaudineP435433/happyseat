class Participant < ApplicationRecord
  belongs_to :table
  has_many :relationships


  validates :first_name, presence: true
  validates :last_name, presence: true
  validates :seat, uniqueness: { scope: :table_id }
  validates :age_range, presence: true

  enum age_range: { children: 0, teenagers: 1, adults: 2, elderly: 3 }

  enum family_type: { groom: 0, bride: 1, others: 2 }

end
