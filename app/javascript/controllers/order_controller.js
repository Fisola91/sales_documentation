import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["quantity", "unitPrice", "total", "date"]

  updateTotal() {
    const quantity = parseFloat(this.quantityTarget.value)
    const unitPrice = parseFloat(this.unitPriceTarget.value)

    if (quantity && unitPrice) {
      const total = quantity * unitPrice
      this.totalTarget.value = total.toFixed(2)
    }
  }

  selectedDate() {
    const dateValue = this.dateTarget.value;

    Turbo.visit(`/orders?date=${dateValue}&commit=see+details`);
  }
}
