ActiveAdmin.register User, as: 'User' do
  menu label: 'Customers'
  permit_params :email, :city, :pincode, :phone_number, :full_name,
    :password, :password_confirmation

  before_create do |user|
    user.role = :user
  end

  controller do
    def scoped_collection
      super.user.active
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
    actions
  end

  filter :email
  filter :full_name
  filter :phone_number
  filter :city
  filter :pincode

  form do |f|
    f.inputs "User Details" do
      f.input :email
      f.input :phone_number, input_html: {maxlength: 10}
      f.input :full_name
      f.input :city
      f.input :pincode
      f.input :password unless f.object.id?
      f.input :password_confirmation, required: true unless f.object.id?
    end
    f.actions
  end

  show do
    attributes_table :email, :full_name, :phone_number, :city, :pincode
  end
end
