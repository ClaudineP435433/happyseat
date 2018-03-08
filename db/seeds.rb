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


puts "start seeds toto"

u = User.create!(email: "toto@toto.com", password: "123456", groom_first_name: "Teddy", groom_last_name: "Smith", bride_first_name: "Pamela", bride_last_name: "Andersson")
sp = SeatingPlan.create!(nb_tables: 6, nb_max_participants: 8, nb_participants: 48, user: u, address: "Chateau de Versailles")

bride = Participant.create!(first_name: u.bride_first_name, last_name: u.bride_last_name, seating_plan: sp, seat: 1, age_range: 2, family_type: 1, status: 1)
groom = Participant.create!(first_name: u.groom_first_name, last_name: u.groom_last_name, seating_plan: sp, seat: 2, age_range: 2, family_type: 0, status: 0)
r = Relationship.create!(link: "couple", first_guest: bride, second_guest: groom)
r.reverse_relationship

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

puts "start seeds kiki"

k = User.create!(email: "kiki@kiki.com", password: "123456", groom_first_name: "Lea", groom_last_name: "Smith", bride_first_name: "Ted", bride_last_name: "Andersson")
spk = SeatingPlan.create!(nb_tables: 6, nb_max_participants: 8, nb_participants: 48, user: k, address: "Chateau Smith Haut Lafitte")

bride2 = Participant.create!(first_name: k.bride_first_name, last_name: k.bride_last_name, seating_plan: spk, seat: 1, age_range: 2, family_type: 1, status: 1)
groom2 = Participant.create!(first_name: k.groom_first_name, last_name: k.groom_last_name, seating_plan: spk, seat: 2, age_range: 2, family_type: 0, status: 0)
r2 = Relationship.create!(link: "couple", first_guest: bride2, second_guest: groom2)
r2.reverse_relationship

y = Table.create!(nb_max_participants: 8, seating_plan: spk, name: "Table 1")
y2 = Table.create!(nb_max_participants: 8, seating_plan: spk, name: "Table 2")
y3 = Table.create!(nb_max_participants: 8, seating_plan: spk, name: "Table 3")
y4 = Table.create!(nb_max_participants: 8, seating_plan: spk, name: "Table 4")
y5 = Table.create!(nb_max_participants: 8, seating_plan: spk, name: "Table 5")
y6 = Table.create!(nb_max_participants: 8, seating_plan: spk, name: "Table 6")


z1 = Participant.create!(first_name: "Camomille", last_name: "Franchin", seating_plan: spk, seat: 5, age_range: 2, family_type: 1)
z2 = Participant.create!(first_name: "Patrick", last_name: "Bonnard", seating_plan: spk, seat: 4, age_range: 2, family_type: 1)
z3 = Participant.create!(first_name: "Francine", last_name: "Pompidou", seating_plan: spk, seat: 10, age_range: 2, family_type: 1)
z4 = Participant.create!(first_name: "Antoine", last_name: "Lejeune", seating_plan: spk, seat: 13, age_range: 2, family_type: 1)
z5 = Participant.create!(first_name: "Monique", last_name: "Champard", seating_plan: spk, seat: 18, age_range: 2, family_type: 1)
z6 = Participant.create!(first_name: "Estelle", last_name: "Galoa", seating_plan: spk, seat: 19, age_range: 2, family_type: 1)

 puts "Finished"
