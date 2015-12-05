class TimeSlotService
  def self.options_for_select
    TimeSlot.all.map {|slot| ["#{format slot.start_hour} - #{format slot.end_hour}", slot.id]}
  end

  def self.format(num_sec)
    "#{'%02d' % (num_sec / 3600)}:#{'%02d' % (num_sec % 3600 / 60)}"
  end
end
