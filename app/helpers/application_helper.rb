module ApplicationHelper
  def new_sales_link
    link_to "Enter sales", orders_path, class: "bg-blue-500 hover:bg-blue-700 text-white font-bold py-2 px-4 rounded focus:shadow-outline"
  end

  def all_sales_link
    link_to "all sales", sales_per_day_index_path, class: "hover:bg-blue-200", style: "color: blue; text-decoration: underline;"
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
end
