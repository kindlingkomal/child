ActiveAdmin.register PickUp do
  config.sort_order = 'created_at_desc'
  menu label: 'Allocations'
  actions :index, :show, :edit, :update
  permit_params :address, :city, :landmark, :start_time, :end_time,
    :date, :time_slot_id, :payment_method

  controller do
    def scoped_collection
      super.includes(:user, :ragpicker)
    end
  end

  index do
    # selectable_column
    column :id
    column 'Payment' do |obj|
      obj.payment_method
    end
    column :pincode
    column :city
    column :address
    column :landmark
    column :subscription
    column "Pick Date" do |obj|
      obj.start_time.strftime('%a %d %b') rescue nil
    end
    column "Time" do |obj|
      obj.pick_time
    end
    column 'Cancelled By' do |obj|
      if (pickup_users = obj.pickup_users.where(status: 'canceled')).count > 0
        pickup_users.joins(:user).distinct.
          select('users.full_name AS full_name').map(&:full_name).join(', ')
      elsif obj.canceled_by_admin
        'admin'
      end
    end

    column "Customer" do |obj|
      obj.customer_name rescue nil
    end
    column "Ragpicker" do |obj|
      obj.ragpicker_name rescue nil
    end

    column 'Rejected by' do |obj|
      obj.pickup_users.where(status: 'rejected').joins(:user).distinct.
        select('users.full_name AS full_name').map(&:full_name).join(', ')
    end

    actions do |pick_up|

      if pick_up.status == PickUp::STATUSES[:pending] && pick_up.start_time.utc > Time.now.utc
        if User.ragpicker.active.count > 0
          process = link_to 'Allocate', admin_notifying_ragpickers_path(pickup_id: pick_up.id), class: 'member_link'
        end
      end
      cancel = link_to 'Cancel', cancel_admin_pick_up_path(pick_up), method: :post,
        class: 'member_link', data: {confirm: 'Are you sure you want to cancel this?' } if authorized?(:cancel, pick_up)

      raw "#{process} #{cancel}"
    end
  end

  filter :id
  filter :with_status_by_partners_in, label: 'Status', as: :select, collection: PickupUser::STATUSES.values.map{|s| [s.capitalize, s]}.unshift(['Pending', 'pending'])

  form do |f|
    f.semantic_errors
    f.inputs do
      f.input :payment_method, as: :radio, collection: ['COP', 'NGO'], label: 'Payment'
      f.input :address
      f.input :city
      f.input :landmark
      f.input :date, as: :string, input_html: {class: 'datepicker2'}
      f.input :time_slot, collection: TimeSlotService.options_for_select, include_blank: true
    end
    actions
  end

  show do
    attributes_table do
      row 'Payment' do |obj|
        obj.payment_method
      end
      row :city
      row :landmark
      row :pincode
      row :address
      row "Pick Date" do |obj|
        obj.start_time.strftime('%a %d %b, %Y') rescue nil
      end
      row "Time" do |obj|
        obj.pick_time
      end
      row :accepted_at do |obj|
        obj.start_time.accepted_at('%d/%m/%Y %H:%M') rescue nil
      end
      row 'Cancelled By' do |obj|
        if (pickup_users = obj.pickup_users.where(status: 'canceled')).count > 0
          pickup_users.joins(:user).distinct.
            select('users.full_name AS full_name').map(&:full_name).join(', ')
        elsif obj.canceled_by_admin
          'admin'
        end
      end
      row 'Rejected by' do |obj|
        obj.pickup_users.where(status: 'rejected').joins(:user).distinct.
          select('users.full_name AS full_name').map(&:full_name).join(', ')
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
        obj.categories.pluck('name').join(', ')
      end
    end
    panel 'Category and price details' do
      if resource.line_items.blank?
        table_for resource.categories do
          column 'Category' do |o|
            link_to o.name, [:admin, o]
          end
          column :price
          column :quantity
          column 'TOTAL', :item_total
        end
      else
        table_for resource.line_items do
          column :category
          column 'Price' do |o|
            o.cost_price
          end
          column :quantity
          column 'TOTAL', :item_total
        end
      end
    end
  end

  collection_action :time_slots, method: :get do
    date = params[:date].to_date
    @timeslots = TimeSlot.all.map {|slot|
      if date + slot.start_hour.seconds > Time.zone.now
        ["#{TimeSlotService.format slot.start_hour} - #{TimeSlotService.format slot.end_hour}", slot.id]
      end
    }.compact
    render 'time_slots.js'
  end

  member_action :cancel, method: :post do
    resource.canceled_at = Time.now
    resource.status = PickUp::STATUSES[:canceled]
    resource.canceled_by_admin = true
    if resource.save
      GcmService.new(nil).delay.cancel_pickup_by_admin(resource)
      redirect_to collection_path, alert: 'The pickup was canceled successfully' and return
    end
    redirect_to collection_path
  end
end
