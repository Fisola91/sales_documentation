class EditOrderForm < OrderFormBase
  def form_method
    :patch
  end

  def form_url
    order_path(order)
  end

  def form_turbo
    true
  end

  def submit
    "Update"
  end
end
