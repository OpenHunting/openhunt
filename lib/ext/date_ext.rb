module DateAndTime::Calculations
  def weekend?
    wday == 0 or wday == 6
  end
end
