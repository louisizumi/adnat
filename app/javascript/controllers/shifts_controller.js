import { Controller } from "stimulus"

export default class extends Controller {
  static targets = [ "startDate", "finishDate", "searchForm", "input", "table", "newForm" ]
  
  showRows(value) {
    const currentShifts = document.querySelectorAll("[data-current='false']");
    const previousShifts = document.querySelectorAll("[data-current='true']");
    if (value === "previous") {
      currentShifts.forEach(row => row.style.display = "none");
      previousShifts.forEach(row => row.style.display = "table-row");
    } else {
      currentShifts.forEach(row => row.style.display = "table-row");
      previousShifts.forEach(row => row.style.display = "none");
    }
  }
  
  showCurrent(e) {
    e.preventDefault();
    this.tableTarget.setAttribute("data-show", "current");
    this.showRows(this.tableTarget.dataset.show);
  }
  
  showPrevious(e) {
    e.preventDefault();
    this.tableTarget.setAttribute("data-show", "previous");
    this.showRows(this.tableTarget.dataset.show);
  }

  filterDate(e) {
    e.preventDefault();
    const url = `${this.searchFormTarget.action}?start_date=${this.startDateTarget.value}&finish_date=${this.finishDateTarget.value}`
    fetch(url, { headers: { 'Accept': 'text/plain' } })
    .then(response => response.text())
    .then((data) => {
      this.tableTarget.innerHTML = data;
    })
    .then(() => {
      this.showRows(this.tableTarget.dataset.show);
    });
  }

  clearDate(e) {
    e.preventDefault();
    const url = `${this.searchFormTarget.action}`
    fetch(url, { headers: { 'Accept': 'text/plain' } })
    .then(response => response.text())
    .then((data) => {
      this.tableTarget.innerHTML = data;
    })
    .then(() => {
      this.startDateTarget.value = null;
      this.finishDateTarget.value = null;
      this.showRows(this.tableTarget.dataset.show);
    });
  }
  
  search(e) {
    const url = `${this.searchFormTarget.action}?query=${this.inputTarget.value}`
    fetch(url, { headers: { 'Accept': 'text/plain' } })
    .then(response => response.text())
    .then((data) => {
      this.tableTarget.innerHTML = data;
    })
    .then(() => {
      this.showRows(this.tableTarget.dataset.show);
    });
  }
  
  sortColumn(e) {
    e.preventDefault();
    console.log(e.target.dataset);
    const url = `${this.searchFormTarget.action}?sort=${e.target.dataset.sort}&order=${e.target.dataset.order}`;
    fetch(url, { headers: { 'Accept': 'text/plain' } })
    .then(response => response.text())
    .then((data) => {
      this.tableTarget.innerHTML = data;
    })
    .then(() => {
      e.target.dataset.order = e.target.dataset.order === "ASC" ? "DESC" : "ASC";
      this.showRows(this.tableTarget.dataset.show);
    });
  }

  showForm(e) {
    e.preventDefault();
    let row, form;
    [row, form] = this.getRows(e.target.dataset.id);
    row.style.display = "none";
    form.style.display = "table-row";
  }

  hideForm(e) {
    e.preventDefault();
    let row, form;
    [row, form] = this.getRows(e.target.dataset.id);
    row.style.display = "table-row";
    form.style.display = "none";
  }

  getRows(id) {
    const row = document.querySelector(`[data-rowid='${id}']`);
    const form = document.querySelector(`[data-formid='${id}']`);
    return [row, form];
  }

  createShift(e) {
    e.preventDefault();
    const url = `${this.newFormTarget.action}`
    fetch(url, {
      method: "POST",
      headers: { 'Accept': "application/json", 'X-CSRF-Token': csrfToken() },
      body: new FormData(this.newFormTarget)
    })
    .then(response => response.json())
    .then((data) => {
      this.tableTarget.insertAdjacentHTML("afterbegin", data.inserted_item);
    })
    .then(() => {
      this.newFormTarget.reset();
    })
  }

  updateShift(e) {
    // e.preventDefault();
    // console.log(e.target);
    // const url = `${this.editFormTarget.action}`
    // fetch(url, {
    //   method: "PATCH",
    //   headers: { 'Accept': "application/json", 'X-CSRF-Token': csrfToken() },
    //   body: new FormData(this.editFormTarget)
    // })
    // .then(response => response.json())
    // .then((data) => {
    //   document.querySelector.insertAdjacentHTML("beforebegin", data.inserted_item);
    // })
    // .then(() => {
    //   this.editFormTarget.reset();
    // })
  }
}
