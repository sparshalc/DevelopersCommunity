import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  connect() {
    console.log("Connecting to data-controller=")
  }
  initialize() {
    this.element.setAttribute('data-action', "click-> bs-modal-form#showModal");
  }

  showModal(event) {
    event.preventDefault();
    this.url = this.element.getAttribute('href');
    fetch(this.url,{
      headers: {
        'Accept': 'text/vnd.turbo_stream.html'
      }
    })
    .then(response => response.text())
    .then(html=> Turbo.renderStreamMessage(html))
  }
}
