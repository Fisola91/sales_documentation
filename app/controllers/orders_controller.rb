class OrdersController < ApplicationController
  
  def index
  end

  def new
    @order = NewOrderComponent.new
  end
  
  def create
    @order = Order.new(order_params)
   

    if @order.save
      # redirect_to order_path(@order)
      respond_to do |format|
        format.turbo_stream do
          # turbo_stream: turbo_stream.append(:orders, @order)
          # turbo_stream.append "orders", target: "new_order" do
          #   render partial: "orders/order", locals: { order: @order }
          # end
          render turbo_stream: turbo_stream.append(
            "new-product-info",
            partial: "orders/order",
            locals: {order: @order }
          )
        end
        format.html { redirect_to order_path(@order) }
      end
      
    else
      render "new"
    end
  end


  def show
    @order = Order.find(params[:id])
    # @component = OrderPage.new(order: @order)
  end

  private

  def order_params
    params.require(:order).permit(:name, :quantity, :unit_price, :total)
  end

end
