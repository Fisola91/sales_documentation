class OrdersController < ApplicationController
  
  def index
    @component = OrderPage.new
  end

  def new
    @order = NewOrderComponent.new
  end

  def create
    @order = Order.new(order_params)
    if @order.save
      redirect_to order_path(@order)
    else
      render "new"
    end
  end

  def show
    @order = Order.find(params[:id])
    @component = OrderPage.new(order: @order)
  end


  private

  def order_params
    params.require(:order).permit(:name, :quantity, :unit_price, :total)
  end

end
