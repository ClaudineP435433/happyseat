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
Relationship.destroy_all


puts "start seeds"

u = User.create!(email: "toto@toto.com", password: "123456", groom_first_name: "Teddy", groom_last_name: "Smith", bride_first_name: "Pamela", bride_last_name: "Andersson")
sp = SeatingPlan.create!(nb_tables: 6, nb_max_participants: 8, nb_participants: 48, user: u)

bride = Participant.create(first_name: u.bride_first_name, last_name: u.bride_last_name, seating_plan: sp, seat: 1, age_range: 2, family_type: 1, status: 1)
groom = Participant.create(first_name: u.groom_first_name, last_name: u.groom_last_name, seating_plan: sp, seat: 2, age_range: 2, family_type: 0, status: 0)


t = Table.create!(nb_max_participants: 8, seating_plan: sp, name: "Table 1")
t2 = Table.create!(nb_max_participants: 8, seating_plan: sp, name: "Table 2")
t3 = Table.create!(nb_max_participants: 8, seating_plan: sp, name: "Table 3")
t4 = Table.create!(nb_max_participants: 8, seating_plan: sp, name: "Table 4")
t5 = Table.create!(nb_max_participants: 8, seating_plan: sp, name: "Table 5")
t6 = Table.create!(nb_max_participants: 8, seating_plan: sp, name: "Table 6")


p1 = Participant.create!(first_name: "Camomille", last_name: "Franchin", seating_plan: sp, seat: 5, age_range: 2, family_type: 1)
p2 = Participant.create!(first_name: "Patrick", last_name: "Bonnard", seating_plan: sp, seat: 4, age_range: 2, family_type: 1)
p3 = Participant.create!(first_name: "Francine", last_name: "Pompidou", seating_plan: sp, seat: 10, age_range: 2, family_type: 1)
p4 = Participant.create!(first_name: "Antoine", last_name: "Lejeune", seating_plan: sp, seat: 13, age_range: 2, family_type: 1)
p5 = Participant.create!(first_name: "Monique", last_name: "Champard", seating_plan: sp, seat: 18, age_range: 2, family_type: 1)
p6 = Participant.create!(first_name: "Estelle", last_name: "Galoa", seating_plan: sp, seat: 19, age_range: 2, family_type: 1)
 puts "Finished"
