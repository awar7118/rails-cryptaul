import { Controller } from "@hotwired/stimulus";
import { createDependency } from "webpack/lib/SingleEntryPlugin";
// APIURL link is from and can be altered at https://www.coingecko.com/en/api/documentation

export default class extends Controller {
  //selecting targets
  static targets = ["indexcontainer"];

  connect() {
    console.log("The 'get cryptos' controller is now loaded!");
    fetch(
      "https://api.coingecko.com/api/v3/coins/markets?vs_currency=gbp&order=market_cap_desc&per_page=100&page=1&sparkline=false&price_change_percentage=1h%2C%2024h%2C%207d%2C%2030d%2C%201y"
    )
      .then((response) => response.json())
      .then((data) => setCryptoInfo(data));
  }
  setCryptoInfo(data) {
    console.log(data);
    data.forEach((crypto) => {
      // Crypto image to be reassesed
      // const cryptoSymbol = crypto.image;
      const cryptoPrice = crypto.current_price;
      const cryptoName = crypto.name;
      const cryptoTicker = crypto.symbol;
      const cryptoMarketCap = crypto.market_cap;
      const element = `<ul class="card-product-infos">
      <li>
        <div>${crypto.symbol}</div>
      </li>
      <li>
        <div>${crypto.name}</div>
      </li>
      <li>
        <div>${crypto.current_price}</div>
      </li>
      <li>
        <div>${crypto.market_cap}</div>
      </li>
    </ul>`;
      this.indexcontainerTarget.insertAdjacentHTML("beforeend", element);
    });
  }
}
