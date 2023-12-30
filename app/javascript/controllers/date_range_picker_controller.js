import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="date-range-picker"
export default class extends Controller {
  connect() {
    new DateRangePicker(this.element, {
      alwaysShowCalendars: true,
      autoApply: true,
      showWeekNumbers: true,
      ranges: {
        'Today': [moment().startOf('day'), moment().endOf('day')],
        'Yesterday': [moment().subtract(1, 'days').startOf('day'), moment().subtract(1, 'days').endOf('day')],
        'Last 7 Days': [moment().subtract(6, 'days').startOf('day'), moment().endOf('day')],
        'This Month': [moment().startOf('month').startOf('day'), moment().endOf('month').endOf('day')],
      },
      locale: {
        format: "YYYY-MM-DD",
      },
    });
  }
}
