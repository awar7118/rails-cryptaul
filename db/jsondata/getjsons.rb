require 'faker'
require 'open-uri'
url = "https://api.coingecko.com/api/v3/coins/markets?vs_currency=gbp&order=market_cap_desc&     per_page=100&page=1&sparkline=false&price_change_percentage=1h%2C%2024h%2C%207d%2C%2030d%2C%201y"

cryptos_serialized = URI.open(url).read
cryptos = JSON.parse(cryptos_serialized)
# p cryptos

# creates a crypto.json file here
File.write('./db/jsondata/crypto.json', JSON.dump(cryptos))

cryptos.each do |c|
  prices_serialized = URI.open("https://api.coingecko.com/api/v3/coins/#{c["id"]}/market_chart/range?vs_currency=gbp&from=1483228800&to=1646306626").read
  prices = JSON.parse(prices_serialized)
  File.write("./db/jsondata/#{c["name"]}.json", JSON.dump(prices))
  puts "finished fetching data for #{c["name"]}"
  sleep 5
end

  # Market History past 2 years link
  # "https://api.coingecko.com/api/v3/coins/bitcoin/market_chart/range?vs_currency=gbp&from=1483228800&to=1646306626"
