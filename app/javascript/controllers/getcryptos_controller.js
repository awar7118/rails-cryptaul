import { Controller } from "@hotwired/stimulus";

export default class extends Controller {
  //select targets
  static targets = ["checkbox"];
  connect() {
    console.log("The 'get cryptos' controller is now loaded!");
  }

  fetchCryptos(event) {
    this.checkboxTargets.forEach((checkbox) => {
      checkbox.checked = event.currentTarget.checked;
      console.log(checkbox);
    });
  }
}
