class OrderPage < ViewComponent::Base
  def initialize(order:)
    @order = order
  end

  private
    attr_reader :order
end
