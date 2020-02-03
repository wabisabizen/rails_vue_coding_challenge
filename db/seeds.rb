# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).

# Create 5 users
user_names = (0..5).map{ |i| { name: Faker::Movies::LordOfTheRings.unique.character } }
User.create(user_names)