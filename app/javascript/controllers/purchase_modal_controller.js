import { Controller } from "stimulus"

export default class extends Controller {
  static targets = ["purchase", "modal", "pounds"]

  connect() {
    // console.log("purchase modal controller is connected")
  }
  expand() {
    this.purchaseTargets.forEach((target) => {
      // target.classList.toggle("collapse")
    })
    // this.modalTarget.classList.toggle("modall")
  }
  calculatePrice(e) {
    // console.log(e.currentTarget.value)
    // console.log(this.poundsTarget.dataset.price)
    // console.log(e.currentTarget.value * this.poundsTarget.dataset.price)
    const calculatedPrice = (e.currentTarget.value * this.poundsTarget.dataset.price)
    this.poundsTarget.innerText = `You're spending £${calculatedPrice.toFixed(2)}`
    console.log(calculatedPrice.class)
  }
}


// Get the modal
var modal = document.getElementById("myModal");

// Get the button that opens the modal
var btn = document.getElementById("myBtn");

// Get the <span> element that closes the modal
var span = document.getElementsByClassName("close")[0];

// When the user clicks on the button, open the modal
btn.onclick = function() {
  modal.style.display = "block";
}

// When the user clicks on <span> (x), close the modal
span.onclick = function() {
  modal.style.display = "none";
}

// When the user clicks anywhere outside of the modal, close it
window.onclick = function(event) {
  if (event.target == modal) {
    modal.style.display = "none";
  }
}
