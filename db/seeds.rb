# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)

user = User.find_by(email: "admin@gocamp.com")
if !user
  user = User.create(name: "Admin", email: "admin@gocamp.com", phone: "12323123", password: "12345678", role: 0)
  puts user
else
  puts "User already exist!"
end
