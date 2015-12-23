class TimeSlotService
  def self.options_for_select
    TimeSlot.all.map {|slot| ["#{format slot.start_hour} - #{format slot.end_hour}", slot.id]}
  end

  def self.format(num_sec)
    if (hour = num_sec / 3600) <= 12
      am_pm = 'AM'
    else
      hour -= 12
      am_pm = 'PM'
    end
    "#{'%02d' % hour}:#{'%02d' % (num_sec % 3600 / 60)} #{am_pm}"
  end
end
