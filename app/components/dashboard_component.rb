# frozen_string_literal: true

class DashboardComponent < ViewComponent::Base
  def initialize(order:)
    @order = order
  end

  def recent_orders
    order
  end

  attr_reader :order
end
