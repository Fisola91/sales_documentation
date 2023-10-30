module DateSelectorHelper
  def set_date(element_id:, date:)
    js_script = %{document.getElementById("#{element_id}").value = "#{date}"}
    page.execute_script(js_script)
  end
end

RSpec.configure do |config|
  config.include DateSelectorHelper, type: :system
end
