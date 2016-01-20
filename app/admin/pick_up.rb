ActiveAdmin.register PickUp do
  config.sort_order = 'created_at_desc'
  menu label: 'Allocations'
  actions :index, :show, :edit, :update
  permit_params :address, :city, :landmark, :start_time, :end_time,
    :date, :time_slot_id, :payment_method

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

    actions do |pick_up|
      if pick_up.status == PickUp::STATUSES[:pending] && pick_up.start_time.utc > Time.now.utc
        except_ids = NotifyingPickup.where(pick_up_id: pick_up.id).pluck(:ragpicker_id).uniq
        if User.ragpicker.where("gcm_registration IS NOT NULL").where.not(id: except_ids).count > 0
          link_to 'Process', admin_notifying_ragpickers_path(pickup_id: pick_up.id), class: 'member_link'
        end
      end
    end
  end

  filter :status, as: :select, collection: PickupUser::STATUSES.values.map{|s| [s.capitalize, s]}

  form do |f|
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
        obj.categories.pluck('name').join(', ')
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
end
