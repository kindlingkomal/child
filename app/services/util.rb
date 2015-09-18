class Util
  def self.is_long?(str)
    0 == (str =~ /\A[+-]?\d+\Z/)
  end

  def self.to_datetime(str)
    if is_long?(str)
      Time.at(str.to_i)
    else
      str.to_datetime
    end
  end

  def self.beginning_of_day(str)
    time = to_datetime(str)
    time.beginning_of_day
  end
end
