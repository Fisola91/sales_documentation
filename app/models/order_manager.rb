class OrderManager
  def initialize(order:, date:, name:, quantity:, unit_price:)
    @order = order
    @date = date
    @name = name
    @quantity = quantity
    @unit_price = unit_price
  end

  def create_order
    Order.new(
      date: date,
      name: name,
      quantity: quantity,
      unit_price: unit_price,
      total: total
    ).save
  end

  def update_order
    order_hash = {
      date: date,
      name: name,
      quantity: quantity,
      unit_price: unit_price,
      total: total
    }

    order.update(order_hash)
  end

  private
  attr_reader :order, :date, :name, :quantity, :unit_price

  def total
    quantity * unit_price
  end
end
