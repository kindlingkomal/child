class CustomerSerializer < ActiveModel::Serializer
  attributes :id, :name, :phone_number
end
