import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="date-range-picker"
export default class extends Controller {
  connect() {
    new DateRangePicker(this.element, {
      locale: {
        format: "YYYY-MM-DD",
      },
    });
  }
}
