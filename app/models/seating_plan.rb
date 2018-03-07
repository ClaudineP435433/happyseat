class SeatingPlan < ApplicationRecord
  require 'csv'

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

  def to_csv(options = {})
    desired_columns = ["name", "age_range", "family_type", "seat"]
    CSV.generate(options) do |csv|
      csv << desired_columns
      @seating_plan.participants.each do |participant|
      csv << participant.attributes.values_at(desired_columns)
      end
    end
  end


end
