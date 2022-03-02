import { Controller } from "stimulus"

export default class extends Controller {
  static targets = [ "hi", "about"]

  connect() {
    this.hiTarget.textContent = 'Hello, dropdown!'
  }
  expand(){
    this.element.innerText = "hi button"
  }
}
