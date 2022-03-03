# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).

require 'faker'
require 'open-uri'
Crypto.destroy_all
url = "https://api.coingecko.com/api/v3/coins/markets?vs_currency=gbp&order=market_cap_desc&     per_page=100&page=1&sparkline=false&price_change_percentage=1h%2C%2024h%2C%207d%2C%2030d%2C%201y"

cryptos = JSON.read("./db/jsondata/crypto.json")
# p cryptos


cryptos.each do |c|
  crypto = Crypto.create!(
  name: c["name"],
  abbreviation: c["symbol"]
  )
  puts "created coin #{crypto.name}"

  prices = JSON.read("./db/jsondata/#{crypto.name}.json")
  prices["prices"].each do |price|
    History.create!(
      price: price[1],
      date: Time.at(price[0]),
      crypto: crypto
    )
  end
  puts "finished fetching data for #{crypto.name}"
end

  # Market History past 2 years link
  # "https://api.coingecko.com/api/v3/coins/bitcoin/market_chart/range?vs_currency=gbp&from=1483228800&to=1646306626"
