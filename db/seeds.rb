# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).

require 'faker'
require 'open-uri'
Crypto.destroy_all
url = "https://api.coingecko.com/api/v3/coins/markets?vs_currency=gbp&order=market_cap_desc&     per_page=100&page=1&sparkline=false&price_change_percentage=1h%2C%2024h%2C%207d%2C%2030d%2C%201y"
# Opening dataset of top 100 cryptos from the crypto.json file
cryptos = JSON.parse(File.read("./db/jsondata/crypto.json"))
# p cryptos

# Iterating of each of the 100 cryptos and creating a crypto from it
cryptos.each do |c|
  crypto = Crypto.create!(
    name: c["name"],
    abbreviation: c["symbol"]
  )
  puts "created coin #{crypto.name}"
  # Opening pircing data for each crypto and get the last 365 days of data to populate our histories table in our database with
  prices = JSON.parse(File.read("./db/jsondata/#{crypto.name}.json"))
  prices["prices"].last(365).each do |price|
    # Need to remove .last(365) to save all historical data. We are only saving time now for development.
    History.create!(
      price: price[1],
      date: Time.at(price[0]/1000),
      crypto: crypto
    )
  end
  puts "finished fetching data for #{crypto.name}"
end

  # Market History past 2 years link
  # "https://api.coingecko.com/api/v3/coins/bitcoin/market_chart/range?vs_currency=gbp&from=1483228800&to=1646306626"
