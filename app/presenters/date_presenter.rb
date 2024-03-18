class DatePresenter
  def self.formatted_monthly_date(date)
    parsed_date(date).strftime("%b %d")
  end

  def self.formatted_monthly_year(date)
    parsed_date(date).strftime("%b %Y")
  end

  def self.date_format(date)
    date.strftime("%Y-%m-%d")
  end

  private

  def self.parsed_date(date)
    Date.parse(date.to_s)
  end
end