class RateSerializer < ActiveModel::Serializer
  attributes :id, :stars, :dimension, :comment

  belongs_to :rater, :class_name => "User"
  belongs_to :rateable, polymorphic: true
end
