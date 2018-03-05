class Participant < ApplicationRecord
  belongs_to :seating_plan
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

  def initial
    "#{first_name[0].capitalize}#{last_name[0].capitalize}"
  end

  # def love_seat
  #   # Besoin de tous les relationships du seating plan
  #   relationships = self.seating_plan.relationships.where(link: "couple")
  #   # on itére sur chaque relationship
  #   relationships.each do |relation|
  #     if relation.first_guest.seat.present?
  #       @super_tables.each do |table, seats|
  #         table_first_guest = table if seats.include? relation.first_guest.seat
  #       end

  #       unless relation.second_guest.seat.present?
  #         if Table.find().available?
  #           relation.second_guest.seat =
  #         else
  #           #allouer à une table dispo au pif
  #         end
  #       end

  #     else
  #       #first_guest n'a pas de seat

  #     end
  #   end

  #   def table_available
  #     @super_tables.each_value do |seats|

  #     end
  #   end

  #   # vérifier si 1er participant a un siége d'alloué & si 2nd aussi(si oui, ci-dessous pas applicable)
  #   # pour chacun des 2 participants, on alloue un seat pour une table qui a 2 places dispo
  #   #
  # end


end
