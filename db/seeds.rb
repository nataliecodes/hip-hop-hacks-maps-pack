# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

require 'csv'

text = File.read('lib/assets/AdWords_Locations.csv')
csv = CSV.parse(text, headers: true)
csv.each do |row|
	Location.create(name: row[1], canonical_name: row[2], target_type: row[5])
end
