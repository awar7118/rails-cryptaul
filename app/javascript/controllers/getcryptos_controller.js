import { Controller } from "@hotwired/stimulus";
// APIURL link is from and can be altered at https://www.coingecko.com/en/api/documentation

export default class extends Controller {
  //select targets
  connect() {
    console.log("The 'get cryptos' controller is now loaded!");
    fetch(
      "https://api.coingecko.com/api/v3/coins/markets?vs_currency=gbp&order=market_cap_desc&per_page=100&page=1&sparkline=false&price_change_percentage=1h%2C%2024h%2C%207d%2C%2030d%2C%201y"
    )
      .then((response) => response.json())
      .then((data) => setCryptoInfo(data));
  }
}
const setCryptoInfo = (data) => {
  data.forEach((crypto) => {
    const cryptoPrice = document.querySelector("#cryptoPrice");
    const cryptoName = document.querySelector("#cryptoName");
    const cryptoTicker = document.querySelector("#cryptoTicker");
    const cryptoMarketCap = document.querySelector("#cryptoMarketCap");

    cryptoPrice.innerText = crypto.current_price;
    cryptoName.innerText = crypto.id;
    cryptoTicker.innerText = crypto.btc;
    cryptoMarketCap.innerText = crypto.location;
  });
};
