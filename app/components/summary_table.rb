class SummaryTable < ViewComponent::Base
  def initialize(orders: [], show: true)
    @orders = orders
    @show = show
  end

  attr_reader :orders, :show

  def show_class
    if show
      ""
    else
      "hidden"
    end
  end
end
