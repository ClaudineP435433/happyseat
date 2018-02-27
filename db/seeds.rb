# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
puts "Destroy all"
Participant.destroy_all
Table.destroy_all
SeatingPlan.destroy_all
User.destroy_all


puts "start seeds"

u = User.create(email: "toto@toto.com", password: "123456", groom_first_name: "Teddy", groom_last_name: "Smith", bride_first_name: "Pamela", bride_last_name: "Andersson")
sp = SeatingPlan.create(nb_participants: 48, user: u)

t = Table.create(nb_max_participants: 8, seating_plan: sp)

5.times do
  Table.create(nb_max_participants: 8, seating_plan: sp)
end

p1 = Participant.create(first_name: "Camomille", last_name: "Franchin", table: t, seat: 5, age_range: "16 - 25", family_type: "Bride")
p2 = Participant.create(first_name: "Patrick", last_name: "Bonnard", table: t, seat: 4, age_range: "16 - 25", family_type: "Bride")
 puts "Finished"
