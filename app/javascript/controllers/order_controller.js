import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["form", "summaryTable", "summaryTableBody", "quantity", "unitPrice", "total"]

  calculate(event) {
    const quantity = parseFloat(this.quantityTarget.value)
    const unitPrice = parseFloat(this.unitPriceTarget.value)

    if (quantity && unitPrice) {
      const total = quantity * unitPrice
      this.totalTarget.value = total.toFixed(2)
    }
  }

  save(event) {
    event.preventDefault()
    const lastForm = this.formTargets[this.formTargets.length - 1]
    const summaryRow = this.createSummaryRow(lastForm)

    this.summaryTableBodyTarget.appendChild(summaryRow)
    this.summaryTableTarget.classList.remove("hidden")
    this.resetFormValues(lastForm)
  }

  resetFormValues(form) {
    const nameInput = form.querySelector("[data-order-target='name']")
    const quantityInput = form.querySelector("[data-order-target='quantity']")
    const unitPriceInput = form.querySelector("[data-order-target='unitPrice']")
    const totalInput = form.querySelector("[data-order-target='total']")
    nameInput.value = ""
    quantityInput.value = ""
    unitPriceInput.value = ""
    totalInput.value = ""
    nameInput.focus()
  }

  createSummaryRow(form) {
    const name = form.querySelector("[data-order-target='name']").value
    const quantity = form.querySelector("[data-order-target='quantity']").value
    const unitPrice = form.querySelector("[data-order-target='unitPrice']").value
    const total = form.querySelector("[data-order-target='total']").value

    const row = document.createElement("tr")
    const nameCell = document.createElement("td")
    const quantityCell = document.createElement("td")
    const unitPriceCell = document.createElement("td")
    const totalCell = document.createElement("td")

    nameCell.textContent = name
    quantityCell.textContent = quantity
    unitPriceCell.textContent = unitPrice
    totalCell.textContent = total

    nameCell.classList.add("border", "px-4", "text-left")
    quantityCell.classList.add("border", "px-4", "text-right")
    unitPriceCell.classList.add("border", "px-4", "text-right")
    totalCell.classList.add("border", "px-4", "text-right")

    row.appendChild(nameCell)
    row.appendChild(quantityCell)
    row.appendChild(unitPriceCell)
    row.appendChild(totalCell)

    return row
  }
}
