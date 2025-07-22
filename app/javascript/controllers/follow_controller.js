import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="follow"
export default class extends Controller {
  connect() {
  }
  
  toggle() {
    this.element.classList.toggle("active")

    if (this.element.classList.contains("active")) {
      console.log("Followed! (Changed to Following)")
    } else {
      console.log("Unfollowed! (Changed to Follow)")
    }
  }
}
