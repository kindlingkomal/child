class CategorySerializer < ActiveModel::Serializer
  attributes :id, :name, :price, :image

  def image
    return nil unless object.image?
    array = %w(medium_url small_url).map { |var|
      [var, object.image.url(var.gsub('_url', ''))]
    }
    Hash[*array.flatten]
  end
end
