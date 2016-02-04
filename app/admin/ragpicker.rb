ActiveAdmin.register User, as: 'Partner' do
  permit_params :email, :city, :pincode, :phone_number, :full_name,
    :password, :password_confirmation

  before_create do |user|
    user.role = :ragpicker
  end

  controller do
    def scoped_collection
      super.ragpicker.active
    end
  end

  index do
    selectable_column
    # id_column
    column :phone_number
    column :email
    column :full_name
    column :city
    column :pincode
    column 'Accepted Count' do |obj|
      obj.pickup_users.where(status: PickupUser::STATUSES[:accepted]).count
    end
    column 'Rejected Count' do |obj|
      obj.pickup_users.where(status: PickupUser::STATUSES[:rejected]).count
    end
    actions
  end

  filter :email
  filter :full_name
  filter :phone_number
  filter :city
  filter :pincode

  form do |f|
    f.inputs "Partner Details" do
      f.input :email
      f.input :phone_number, input_html: {maxlength: 10}
      f.input :full_name
      f.input :city
      f.input :pincode
      f.input :password unless f.object.id?
      f.input :password_confirmation, required: true unless f.object.id?
    end
    f.actions do
      f.action(:submit, label: "#{f.object.id? ? 'Update' : 'Create'} Partner")
      f.cancel_link
    end
  end

  show do
    attributes_table :email, :full_name, :phone_number, :city, :pincode
    resource.ragpicker_rates.order(:created_at).each do |rate|
      panel 'Rating' do
        attributes_table_for rate do
          row 'DATE' do |o|
            o.created_at.strftime('%B %d, %Y')
          end
          row 'RATER' do |o|
            o.rater.full_name
          end
          row :score do |o|
            o.stars
          end
          row :comment
        end
      end
    end
  end
end
