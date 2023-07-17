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
   
    const sumsRow = this.summaryTableBodyTarget.querySelector("[data-order-target='sumsRow']")
    if (sumsRow) {
      this.summaryTableBodyTarget.insertBefore(summaryRow, sumsRow)
    } else {
      this.summaryTableBodyTarget.appendChild(summaryRow)
    }
    this.summaryTableTarget.classList.remove("hidden")

    const summaryRows = Array.from(this.summaryTableBodyTarget.querySelectorAll("tr.line-item"))
    if (summaryRows.length >= 2) {
      const sumsRow = this.createSumsRow(summaryRows)
      this.summaryTableBodyTarget.appendChild(sumsRow)
    }

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
    row.classList.add("line-item")
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

  createSumsRow(summaryRows) {
    let sumsRow = this.summaryTableBodyTarget.querySelector("[data-order-target='sumsRow']")

    if (!sumsRow) {
      sumsRow = document.createElement("tr")
      sumsRow.classList.add("sums-row", "font-bold")
      sumsRow.setAttribute("data-order-target", "sumsRow")
      const nameCell = document.createElement("td")
      nameCell.classList.add("border", "px-4", "text-left")
      nameCell.textContent = "Total"
      sumsRow.appendChild(nameCell)
      this.summaryTableBodyTarget.appendChild(sumsRow)
    }

    let quantityCell = sumsRow.querySelector("[data-order-target='totalQuantity']")
    let totalCell = sumsRow.querySelector("[data-order-target='totalAmount']")

    if (!quantityCell) {
      const newQuantityCell = document.createElement("td")
      newQuantityCell.setAttribute("data-order-target", "totalQuantity")
      sumsRow.appendChild(newQuantityCell)
      quantityCell = sumsRow.querySelector("[data-order-target='totalQuantity']")
      quantityCell.classList.add("border", "px-4", "text-right")

      const unitPriceCell = document.createElement("td")
      unitPriceCell.classList.add("border", "px-4")
      sumsRow.appendChild(unitPriceCell)
    }

    if (!totalCell) {
      const newTotalCell = document.createElement("td")
      newTotalCell.setAttribute("data-order-target", "totalAmount")
      sumsRow.appendChild(newTotalCell)
      totalCell = sumsRow.querySelector("[data-order-target='totalAmount']")
      totalCell.classList.add("border", "px-4", "text-right")
    }

    const quantities = summaryRows
      .map(row => parseFloat(row.cells[1].textContent))
      .filter(value => !isNaN(value))
    const totals = summaryRows
      .map(row => parseFloat(row.cells[3].textContent))
      .filter(value => !isNaN(value))

    const totalQuantity = quantities.reduce((sum, value) => sum + value, 0)
    const totalAmount = totals.reduce((sum, value) => sum + value, 0)

    quantityCell.textContent = totalQuantity.toFixed(2)
    totalCell.textContent = totalAmount.toFixed(2)

    return sumsRow;
  }
}
