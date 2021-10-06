# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

blessed = User.create!(
  first_name: "Blessed",
  last_name: "Sibanda",
  email: "blessed@example.com",
  password: "1234pass",
  confirmed_at: Time.zone.now,
)

mike = User.create!(
  first_name: "Michael",
  last_name: "Mutopa",
  email: "myk@example.com",
  password: "1234pass",
  confirmed_at: Time.zone.now,
)

maths = Subject.create!(title: "Mathematics")
Subject.create!(title: "Engineering")
web = Subject.create!(title: "Web Development")

Course.create!(
  subject: web,
  title: "Full Stack Development with Django",
  overview: "The complete guide to the django web framework",
  owner: blessed,
)

Course.create!(
  subject: maths,
  title: "Engineering Mathematics",
  overview: "Advanced mathematical principles for engineers and scientists",
  owner: mike,
)

Course.create!(
  subject: web,
  title: "Complete Rails 6",
  overview: "The comprehensive course on Ruby on Rails 6",
  owner: blessed,
)

30.times do |i|
  Course.create!(
    subject: Subject.all.sample,
    title: Faker::Lorem.words(number: rand(2..5)).join(" ").capitalize,
    overview: Faker::Lorem.paragraphs(number: 4).join,
    owner: blessed,
  )
end
