import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="tab"
export default class extends Controller {
  static targets = ["photoTab", "albumTab"]

  goToPhoto() {
    Turbo.visit("/users/photos")
  }

  goToAlbum() {
    Turbo.visit("/users/albums")
  }
}


  

