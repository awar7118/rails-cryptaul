# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
require 'faker'
require 'open-uri'

  40.times do
    crypto = Crypto.create!(
      name: Faker::CryptoCoin.coin_name,
      abbreviation: Faker::CryptoCoin.acronym,
      price: [300, 400, 500, 600, 700].sample
   )
   crypto.save!
  end
