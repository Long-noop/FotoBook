import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="follow"
export default class extends Controller {
    static targets = [ "label" ]

  connect() {
  }
  
  toggle() {
    this.element.classList.toggle("active")
    this.labelTarget.classList.toggle("active")

    if (this.element.classList.contains("active")) {
      this.labelTarget.textContent = "Following"
      console.log("Followed! (Changed to Following)")
    } else {
      this.labelTarget.textContent = "Follow"
      console.log("Unfollowed! (Changed to Follow)")
    }
  }
}
