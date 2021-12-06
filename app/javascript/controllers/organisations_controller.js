import { Controller } from "stimulus"
import { csrfToken } from "@rails/ujs"

export default class extends Controller {
  static targets = [ "form", "list" ]

  submit(e) {
    e.preventDefault();
    const url = `${this.formTarget.action}`
    fetch(url, {
      method: "POST",
      headers: { 'Accept': "application/json", 'X-CSRF-Token': csrfToken() },
      body: new FormData(this.formTarget)
    })
    .then(response => response.json())
    .then((data) => {
      this.listTarget.insertAdjacentHTML("beforeend", data.inserted_item);
    })
    .then(() => {
      this.formTarget.reset();
    })
  }
}
