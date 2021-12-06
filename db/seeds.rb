# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

puts "Clearing database..."
Shift.destroy_all
Employment.destroy_all
Organisation.destroy_all
User.destroy_all
puts "Database cleared."

puts "Seeding organisations..."
10.times do
  organisation = Organisation.new(
    name: Faker::Company.name, 
    hourly_rate: rand(0.01...100.00)
  )
  puts "Organisation created." if organisation.save
end
puts "#{Organisation.count} organisations seeded."

puts "Seeding users and jobs..."
user = User.new(
  full_name: "Test Testerson",
  email: "test@test.com",
  password: "password"
)
puts "Test account created. (Email: 'test@test.com', Password: 'password')" if user.save

rand(1..2).times do
  employment = Employment.new(
    user_id: user.id,
    organisation_id: Organisation.all.sample.id
  )
  puts "Employment seeded for test user." if employment.save
end
puts "#{Employment.count} jobs seeded for test user."

10.times do
  user = User.new(
    full_name: Faker::Name.name,
    email: Faker::Internet.email,
    password: "password"
  )
  puts "User created." if user.save
  rand(1..2).times do
    employment = Employment.new(
      user_id: user.id,
      organisation_id: Organisation.all.sample.id
    )
    puts "Employment seeded." if employment.save
  end
end
puts "#{User.count} users seeded."
puts "#{Employment.count} jobs seeded."

puts "Seeding shifts..."
50.times do
  user = User.all.sample
  organisation = user.organisations.sample
  start = Faker::Time.between(from: DateTime.now - 365, to: DateTime.now, format: :default)
  shift = Shift.new(
    user_id: user.id,
    organisation_id: organisation.id,
    start: start,
    finish: Time.parse(start) + rand(60..86400),
    break: rand(0..120)
  )
  puts "Shift seeded." if shift.save
end
puts "Shifts seeded."

puts "Making some employees redundant..."
5.times do
  Employment.all.sample.destroy
end
puts "5 employees made redundant."

puts "Seed complete."