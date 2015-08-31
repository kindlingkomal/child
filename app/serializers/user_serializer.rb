class UserSerializer < ActiveModel::Serializer
  attributes :id, :email, :created_at, :authentication_token

  def authentication_token
    show_token = meta.try(:[], :show_token)
    show_token ? object.authentication_token : nil
  end
end
