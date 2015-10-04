class InvitationSerializer < ActiveModel::Serializer
  attributes :id, :name, :phone_number, :accepted_at

  belongs_to :user
  belongs_to :invited_by, class_name: 'User'

end
