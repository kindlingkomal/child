class SubscriptionService

  def self.next_date(frequency, date)
    case frequency
    when 'daily'
      new_date = date + 1.day
      wday = new_date.wday
      if wday == 6
        new_date += 2.days
      elsif wday == 0 #sunday
        new_date += 1.day
      end
    when 'weekly'
      new_date = date + 7.days
    when 'monthly'
      wday = date.wday
      new_date = date + 1.month
      unless new_date.wday == wday
        loop do
          new_date += 1.day
          break new_date if new_date.wday == wday
        end
      end
    else
      nil
    end
  end

  def self.next_valid_date(sub, now)
    timeslot = TimeSlot.find_by id: time_slot_id
    return nil if timeslot.nil?
    new_date = sub.date
    loop do
      new_date = SubscriptionService.next_date(sub.frequency, new_date)
      start_time = new_date + timeslot.start_hour.seconds
      break new_date if start_time > now
    end
    new_date
  end
end
