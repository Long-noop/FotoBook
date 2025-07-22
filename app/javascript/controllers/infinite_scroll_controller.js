import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static values = {
    url: String
  }

  static targets = ["loading"]

  connect() {
    this.observer = new IntersectionObserver(entries => {
      if (entries[0].isIntersecting) this.loadMore()
    })

    if (this.hasLoadingTarget) this.observer.observe(this.loadingTarget)
  }

  loadMore() {
    if (this.loading) return
    this.loading = true

    const nextPageLink = document.querySelector(".pagination .page-link[rel='next']")
    console.log("Next page link:", nextPageLink?.href)
    if (!nextPageLink) {
      this.observer.disconnect()
      return
    }

    fetch(nextPageLink.href, {
      headers: {
        Accept: "text/vnd.turbo-stream.html"
      }
    })
      .then(response => response.text())
      .then(html => Turbo.renderStreamMessage(html))
      .finally(() => this.loading = false)
  }


  disconnect() {
    if (this.observer && this.hasLoadingTarget) this.observer.unobserve(this.loadingTarget)
  }
}
