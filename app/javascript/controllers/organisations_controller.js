import { Controller } from "stimulus"

export default class extends Controller {
  static targets = [ "form", "list" ]

  submit(e) {
    e.preventDefault();
    const url = `${this.formTarget.action}`
    fetch(url, { headers: { 'Accept': 'text/plain' } })
    .then(response => response.text())
    .then((data) => {
      this.listTarget.insertAdjacentHTML("beforeend", data);
    })
  }
}
