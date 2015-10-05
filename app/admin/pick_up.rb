ActiveAdmin.register PickUp do

  index do
    selectable_column
    # column :title

    column :pincode
    column :city
    column :address
    column :subscription
    column "Pick Date" do |obj|
      obj.start_time.strftime('%a %d %b') rescue nil
    end
    column "Time" do |obj|
      obj.pick_time
    end
    column :accepted_at do |obj|
      obj.start_time.accepted_at('%d/%m/%Y %H:%M') rescue nil
    end
    column :canceled_at do |obj|
      obj.start_time.canceled_at('%d/%m/%Y %H:%M') rescue nil
    end
    # column :proceeded_at
    column :category_set do |obj|
      obj.categories.pluck('name').join(', ')
    end
    # column :created_at
    # column :updated_at
    # column :lat
    # column :lon
    column :user_id do |obj|
      obj.user.full_name rescue nil
    end
    column :total
    # column :customer_id
  end

# See permitted parameters documentation:
# https://github.com/activeadmin/activeadmin/blob/master/docs/2-resource-customization.md#setting-up-strong-parameters
#
# permit_params :list, :of, :attributes, :on, :model
#
# or
#
# permit_params do
#   permitted = [:permitted, :attributes]
#   permitted << :other if resource.something?
#   permitted
# end


end
