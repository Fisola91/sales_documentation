module ApplicationHelper
  def homepage_link
    link_to "Homepage", orders_path, class: "bg-blue-500 hover:bg-blue-700 text-white font-bold py-2 px-4 w-full rounded focus:shadow-outline"
  end
end
