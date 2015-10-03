class RatingCacheSerializer < ActiveModel::Serializer
  attributes :id, :avg, :qty, :dimension

  belongs_to :cacheable, polymorphic: true
end
