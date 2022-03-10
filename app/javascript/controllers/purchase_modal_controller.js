import { Controller } from "stimulus"

export default class extends Controller {
  static targets = ["pounds", "price", "balance", "quantity", "confirm"]

  connect() {
    console.log(parseInt(this.balanceTarget.textContent))
    console.log(parseFloat(this.priceTarget.textContent))
    console.log("purchase modal controller is connected")
    const maxValue = parseInt(this.balanceTarget.textContent) / parseFloat(this.priceTarget.textContent)
    console.log(maxValue)
    this.quantityTarget.max = maxValue
    this.quantityTarget.placeholder = maxValue
    this.quantityTarget.min = 0
    if (maxValue < 1) {
      this.quantityTarget.step = 1 / parseInt(this.priceTarget.textContent)
      console.log(1 / parseInt(this.priceTarget.textContent))
    }
  }

  calculatePrice(e) {
    console.log(e.currentTarget.value)
    console.log(this.poundsTarget.dataset.price)
    console.log(e.currentTarget.value * this.poundsTarget.dataset.price)
    const calculatedPrice = (e.currentTarget.value * this.poundsTarget.dataset.price)
    if (calculatedPrice > parseInt(this.balanceTarget.textContent)){
      this.poundsTarget.innerText = `Insufficient balance`
      this.confirmTarget.classList.add("disabled")
    }

    if (calculatedPrice <= parseInt(this.balanceTarget.textContent)){
      this.poundsTarget.innerText = `You're spending £${calculatedPrice.toFixed(2)}`
      this.confirmTarget.classList.remove("disabled")
    }
  }
}


// Get the modal
var modal = document.getElementById("myModal");

// Get the button that opens the modal
var btn = document.getElementById("myBtn");

// Get the <span> element that closes the modal
var span = document.getElementsByClassName("close")[0];

// When the user clicks on the button, open the modal
if (btn) {
  btn.onclick = function() {
  modal.style.display = "block";
  }
}
// When the user clicks on <span> (x), close the modal
if (span) {
  span.onclick = function() {
  modal.style.display = "none";
  }
}

// When the user clicks anywhere outside of the modal, close it
window.onclick = function(event) {
  if (event.target == modal) {
    modal.style.display = "none";
  }
}
