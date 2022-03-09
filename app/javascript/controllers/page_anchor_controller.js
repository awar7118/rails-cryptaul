import { Controller } from "stimulus"

export default class extends Controller {
  static targets = ["purchase", "modal", "pounds", "price", "balance", "quantity", "sell"]

  connect() {
    console.log("anchor controller is connected")

  }

  anchor() {

  }
}
