ActiveAdmin.register User, as: 'NotifyingRagpicker' do
  actions :index
  menu false

  controller do
    def scoped_collection
      # except_ids = params[:pickup_id].blank? ? [] : NotifyingPickup.where(pick_up_id: params[:pickup_id]).pluck(:ragpicker_id).uniq
      # super.ragpicker.where("gcm_registration IS NOT NULL").where.not(id: except_ids)
      super.ragpicker.active
    end
  end

  index do
    render('notify_form') if params[:pickup_id].present?
    selectable_column
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

  collection_action :batch_action, method: :post do # send notifications
    ids = params[:collection_selection] || []
    pickup_id = params[:pickup_id].presence
    if pickup_id && ids.any? && (pick_up = PickUp.find_by(id: pickup_id))
      gcm_service = GcmService.new(current_admin_user)
      gcm_service.delay.notify_new_pickup(pick_up, User.ragpicker.where(id: ids).pluck(:gcm_registration).compact)
      User.ragpicker.where(id: ids).find_each do |ragpicker|
        NotifyingPickup.create(ragpicker_id: ragpicker.id, pick_up_id: pick_up.id)
      end

      redirect_to collection_path(pickup_id: pickup_id), alert: "Notifications will be sent."
    elsif ids.blank?
      redirect_to collection_path(pickup_id: pickup_id), alert: "Please select ragpickers"
    end
  end
end
