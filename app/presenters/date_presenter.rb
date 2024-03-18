class DatePresenter
  def self.formatted_date(date, monthly = false)
    parsed_date = Date.parse(date.to_s)
    monthly ? parsed_date.strftime("%b %Y") : parsed_date.strftime("%b %d")
  end
end