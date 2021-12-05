import { Controller } from "stimulus"

export default class extends Controller {
  showForm(e) {
    e.preventDefault();
    const row = this.getRow(e.target.dataset.id);
    const form = this.getForm(e.target.dataset.id);
    row.style.display = "none";
    form.style.display = "table-row";
  }

  hideForm(e) {
    e.preventDefault();
    const row = this.getRow(e.target.dataset.id);
    const form = this.getForm(e.target.dataset.id);
    row.style.display = "table-row";
    form.style.display = "none";
  }

  getRow(id) {
    return document.querySelector(`[data-row-id='${id}']`);
  }

  getForm(id) {
    return document.querySelector(`[data-form-id='${id}']`);
  }
}
