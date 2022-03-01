import { Controller } from "@hotwired/stimulus";
// APIURL link is from and can be altereed at https://www.coingecko.com/en/api/documentation
apiurl =
  "https://api.coingecko.com/api/v3/coins/markets?vs_currency=gbp&order=market_cap_desc&per_page=100&page=1&sparkline=false&price_change_percentage=1h%2C%2024h%2C%207d%2C%2030d%2C%201y";

export default class extends Controller {
  //select targets
  connect() {
    console.log("The 'get cryptos' controller is now loaded!");
  }

  fetchCryptos(event) {
    fetch(apiurl)
      .then((response) => response.json())
      .then((data) => console.log(data));
  }
}
