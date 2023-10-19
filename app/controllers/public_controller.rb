class PublicController < ApplicationController
  def index
    @component = Prototype.new
  end
end
