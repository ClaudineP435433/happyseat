class Participant < ApplicationRecord
  belongs_to :table
  has_many :relationships


  validates :first_name, presence: true
  validates :last_name, presence: true
  validates :seat, uniqueness: { scope: :table_id }
  validates :age_range, presence: true

  CATEGORIES_AGE = ["0 - 15", "16 - 25", "26 - 62", "63 +"]
  validates :age_range, inclusion: {
    in: CATEGORIES_AGE,
    message: "%{value} is not a valid category"
  }

  CATEGORIES_TYPE = ["Groom", "Bride", "Others"]
  validates :family_type, inclusion: {
    in: CATEGORIES_TYPE,
    message: "%{value} is not a valid category"
  }

end
