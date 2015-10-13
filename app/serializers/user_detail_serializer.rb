class UserDetailSerializer < ActiveModel::Serializer
  attributes :id, :email, :full_name, :phone_number, :authentication_token,
    :avatar, :gender, :address, :city, :notified, :pincode, :lat, :lon


  def avatar
    JSON.parse(object.avatar) rescue object.avatar
  end
end
