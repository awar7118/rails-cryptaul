import { Controller } from "@hotwired/stimulus";

export default class extends Controller {
  static targets = ["cryptos"];

  connect() {
    console.log("Hello from clickable index Stimulus controller");
    console.log(this.cryptosTargets);
  }

  clickable(e) {
    window.location = e.currentTarget.dataset.link
  }
}
