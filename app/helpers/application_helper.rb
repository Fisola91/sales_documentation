module ApplicationHelper
  def new_sales_link
    link_to "Enter sales", orders_path, class: "bg-blue-500 hover:bg-blue-700 text-white font-bold py-2 px-4 rounded focus:shadow-outline"
  end

  def hover_color
    "hover:text-blue-950"
  end

  def color_style
    "color: blue; text-decoration: underline;"
  end

  def all_sales_link_with_bg_blue
    link_to "all sales", sales_per_day_index_path, class: "bg-blue-500 hover:bg-blue-700 text-white font-bold py-2 px-4 rounded focus:shadow-outline"
  end

  def button_style
    "border border-blue-500 hover:bg-blue-300 mr-4 text-black font-normal py-2 px-4 rounded-full focus:shadow-outline"
  end

  def button_style_bg_blue
    "bg-blue-500 hover:bg-blue-700 text-white font-bold py-2 px-4 rounded-md focus:shadow-outline"
  end

  def current_user_orders
    current_user.orders
  end

  def image_tag_for_nav_bar
    image_tag('lewagon.png', alt: 'sales logo', size: '70x70', id: "image", class: "rounded-full")
  end
end
