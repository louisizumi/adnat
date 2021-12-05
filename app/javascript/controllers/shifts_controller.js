import { Controller } from "stimulus"

export default class extends Controller {
  static targets = [ "currentShifts", "previousShifts" ]

  showCurrent(e) {
    e.preventDefault();
    this.currentShiftsTarget.style.display = "block";
    this.previousShiftsTarget.style.display = "none";
  }

  showPrevious(e) {
    e.preventDefault();
    this.currentShiftsTarget.style.display = "none";
    this.previousShiftsTarget.style.display = "block";
  }

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
    return document.querySelector(`[data-rowid='${id}']`);
  }

  getForm(id) {
    return document.querySelector(`[data-formid='${id}']`);
  }
}
