ActiveAdmin.register PickUp do
  actions :index, :show

  index do
    # selectable_column
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
    #column :category_set do |obj|
    #  obj.categories.pluck('name').join(', ')
    #end
    # column :lat
    # column :lon
    column "Customer" do |obj|
      obj.customer_name rescue nil
    end
    column "Ragpicker" do |obj|
      obj.ragpicker_name rescue nil
    end

    # column :total
    # column :customer_id
    actions
  end

  filter :status, as: :select, collection: PickupUser::STATUSES.values

  show do
    # attributes_table :id, :user, :postable_type, :content, :like, :created_at, :updated_at
    attributes_table do
      row :city
      row :pincode
      row :address
      row "Pick Date" do |obj|
        obj.start_time.strftime('%a %d %b') rescue nil
      end
      row "Time" do |obj|
        obj.pick_time
      end
      row :accepted_at do |obj|
        obj.start_time.accepted_at('%d/%m/%Y %H:%M') rescue nil
      end
      row :canceled_at do |obj|
        obj.start_time.canceled_at('%d/%m/%Y %H:%M') rescue nil
      end

      row :lat
      row :lon
      row "Customer" do |obj|
        obj.customer_name rescue nil
      end
      row "Ragpicker" do |obj|
        obj.ragpicker_name rescue nil
      end
      #row :total
      row "Categories" do |obj|
        Category.where(id: obj.category_set).pluck('name').join(', ')
      end
    end
  end
end
