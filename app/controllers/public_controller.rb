class PublicController < ApplicationController
  def index
    @component = OrderPage.new
  end
end
