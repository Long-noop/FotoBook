import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["input", "container", "template", "deletedInput"]

  connect() {
    console.log("AlbumPhotosController connected");
  }

  preview(event) {
    const files = event.target.files;
    const placeholder = this.containerTarget.querySelector(".add-photo-placeholder");

    for (let i = 0; i < files.length; i++) {
      const file = files[i];
      if (file.type.startsWith('image/')) {
        const reader = new FileReader();
        reader.onload = (e) => {
          const html = this.templateTarget.content.cloneNode(true);
          const img = html.querySelector("img");
          img.src = e.target.result;
          this.containerTarget.insertBefore(html, placeholder);
        };
        reader.readAsDataURL(file);
      }
    }
  }

  remove(event) {
    const button = event.target.closest("button");
    const item = button.closest(".photo-preview-item");

    if (item) {
      const photoId = button.dataset.photoId;
      item.remove();

      if (photoId) {
        const inputContainer = this.deletedInputTarget;
        const newInput = document.createElement("input");
        newInput.type = "hidden";
        newInput.name = "album[deleted_photo_ids][]";
        newInput.value = photoId;
        inputContainer.appendChild(newInput);

        console.log(">>> Added deleted photo ID:", photoId);
        console.log(">>> Input DOM:", inputContainer.innerHTML);
      }
    }
  }
}
