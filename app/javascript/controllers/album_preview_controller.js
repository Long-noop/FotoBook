import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["input", "container", "template"]

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
        console.log(`Cần gửi yêu cầu xoá ảnh có ID: ${photoId}`);
      } else {
        console.log("Ảnh vừa upload đã bị xoá khỏi DOM");
      }
    }
  }
}
