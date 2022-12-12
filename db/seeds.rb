# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)


6.times do
  branch = Branch.create!(name: Faker::Company.name, address: Faker::Address.full_address, phone: Faker::PhoneNumber.phone_number)
  15.times do
    day = rand(0..6)
    if branch.schedules.where(day: day).empty?
      first = Time.parse("#{rand(0..12)}:00")
      second = Time.parse("#{rand(13..23)}:00")
      Schedule.create!(branch_id: branch.id, day: day, start: first, finish: second)
    end
  end
end

User.create!(email: 'admin@admin.com', password: '123456', password_confirmation: '123456', role: 1)

10.times do
  User.create!(email: Faker::Internet.email, password: "password", password_confirmation: "password", role: 1)
end

10.times do
  User.create!(email: Faker::Internet.email, password: "password", password_confirmation: "password", role: 2, branch_id: Branch.all.ids.sample)
end

10.times do
  User.create!(email: Faker::Internet.email, password: "password", password_confirmation: "password", role: 0)
end

Branch.all.each do |branch|
  2.times do
    schedule = branch.schedules.all.sample
    date = DateTime.now.change(hour: schedule.start.hour + 1, min: schedule.start.min)
    Turn.create(branch_id: branch.id, user_id: User.all.ids.sample, date: date, reason: Faker::Lorem.sentence, status: 0, comment: nil)
  end
end

puts "DB Seeded"
