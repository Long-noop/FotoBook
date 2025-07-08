import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["input", "preview", "remove"]

  connect() {
    this.placeholder = this.previewTarget.dataset.placeholder
  }

  previewImage() {
    const file = this.inputTarget.files[0]
    if (file && file.type.startsWith("image/")) {
      const reader = new FileReader()
      reader.onload = (e) => {
        this.previewTarget.src = e.target.result
        this.previewTarget.classList.remove("placeholder-image")
        this.previewTarget.classList.add("attached-image")
        this.element.classList.add("attached")
        this.removeTarget.style.display = "flex"
      }
      reader.readAsDataURL(file)
    }
  }

  clearImage() {
    this.inputTarget.value = ""
    this.previewTarget.src = this.placeholder
    this.previewTarget.classList.remove("attached-image")
    this.previewTarget.classList.add("placeholder-image")
    this.element.classList.remove("attached")
    this.removeTarget.style.display = "none"
  }
}
