import { Controller } from "@hotwired/stimulus";

export default class extends Controller {
  static targets = ["cryptos"];

  connect() {
    console.log("Hello from clickable index Stimulus controller");
    console.log(this.cryptosTargets);
  }

  clickable() {
    console.log("this clicked");
    this.cryptosTargets.forEach((crypto) => {
      window.location = this.dataset.link;
      // console.log(crypto);
    });
  }
}
