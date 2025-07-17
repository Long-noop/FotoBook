import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="tab"
export default class extends Controller {
  static targets = ["photoTab", "albumTab"]

  goToPhoto() {
    const currentPath = window.location.pathname;
    const isDiscovery = currentPath.includes("discovery");
    const path = isDiscovery ? "/users/photos/discovery" : "/users/photos/feed";
    Turbo.visit(path);
  }

  goToAlbum() {
    const currentPath = window.location.pathname;
    const isDiscovery = currentPath.includes("discovery");
    const path = isDiscovery ? "/users/albums/discovery" : "/users/albums/feed";
    Turbo.visit(path);
  }
}


  

