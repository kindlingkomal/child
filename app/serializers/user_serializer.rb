class UserSerializer < ActiveModel::Serializer
  attributes :id, :email, :full_name, :phone_number, :created_at, :authentication_token,
    :avatar, :gender, :address, :city, :notified, :pincode, :lat, :lon,
    :yard_number, :is_yard

  def authentication_token
    show_token = meta.try(:[], :show_token)
    show_token ? object.authentication_token : nil
  end

  def avatar
    JSON.parse(object.avatar) rescue object.avatar
  end
end
