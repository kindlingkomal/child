# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

Category.create(name: 'News Paper', price: 15)
Category.create(name: 'Clothes', price: 25)
Category.create(name: 'Steel', price: 150)
Category.create(name: 'Plastic', price: 55)

TimeSlot.create(start_hour: 9.hours, end_hour: 10.hours)
TimeSlot.create(start_hour: 10.hours + 30.minutes, end_hour: 11.hours + 30.minutes)
TimeSlot.create(start_hour: 13.hours, end_hour: 14.hours)
TimeSlot.create(start_hour: 15.hours, end_hour: 16.hours)
TimeSlot.create(start_hour: 16.hours + 30.minutes, end_hour: 17.hours + 30.minutes)
