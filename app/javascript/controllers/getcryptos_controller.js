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
// Need to do 2 for each loops to iterate through and make sure the class changes
const setCryptoInfo = (data) => {
  data.forEach((crypto) => {
    const cryptoSymbol = document.querySelector("#crypto-symbol");
    const cryptoPrice = document.querySelector("#cryptoPrice");
    const cryptoName = document.querySelector("#cryptoName");
    const cryptoTicker = document.querySelector("#cryptoTicker");
    const cryptoMarketCap = document.querySelector("#cryptoMarketCap");

    cryptoSymbol.innerText = crypto.image;
    cryptoPrice.innerText = crypto.current_price;
    cryptoName.innerText = crypto.id;
    cryptoTicker.innerText = crypto.btc;
    cryptoMarketCap.innerText = crypto.location;
  });
};

data.forEach((crypto) => {
  <div class="card-product">
    <ul class="card-product-infos">
      <li>
        <div id="crypto-symbol">Crypto symbol</div>
      </li>
      <li>
        <div id="crypto-price">crypto price</div>
      </li>
      <li>
        <div id="crypto-name">Crypto name</div>
      </li>
      <li>
        <div id="crypto-ticker">Crypto Ticker</div>
      </li>
      <li>
        <div id="24hr-change">crypto 24hr change</div>
      </li>
      cryptoMarketCap
      <li>
        <div id="cryptoMarketCap">crypto MarketCap</div>
      </li>
    </ul>
  </div>;
});

// Trying it the simple way, on connect iterate through the response and display
// const setCryptoInfo = (data) => {
data.forEach((crypto) => {
  <div class="card-product">
    <ul class="card-product-infos">
      <li>
        <div id="crypto-price">crypto.current_price</div>
      </li>
      <li>
        <div id="crypto-name">#{crypto.id}</div>
      </li>
      <li>
        <div id="crypto-ticker">#{crypto.symbol}</div>
      </li>
      <li>
        <div id="24hr-change">#{crypto.price_change_24h}</div>
      </li>
      cryptoMarketCap
      <li>
        <div id="cryptoMarketCap">#{crypto.market_cap}</div>
      </li>
    </ul>
  </div>;
});
// };
