class CategorySerializer < ActiveModel::Serializer
  attributes :id, :name, :price, :image

  def image
    object.image.url(:thumbnail)
  end
end
