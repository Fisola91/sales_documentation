class DatePresenter
  def self.formatted_monthly_date(date)
    parsed_date(date).strftime("%b %d")
  end

  def self.formatted_monthly_year(date)
    parsed_date(date).strftime("%b %Y")
  end

  private

  def self.parsed_date(date)
    Date.parse(date.to_s)
  end
end