class NewOrderForm < OrderFormBase
  def form_method
    :post
  end

  def form_url
    orders_path
  end

  def form_turbo
    true
  end

  def submit
    "Save"
  end
end
