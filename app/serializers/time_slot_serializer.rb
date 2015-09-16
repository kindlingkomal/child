class TimeSlotSerializer < ActiveModel::Serializer
  attributes :id, :start_hour, :end_hour

end
