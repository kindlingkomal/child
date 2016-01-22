ActiveAdmin.register Rate, as: 'Rated Orders' do
  config.filters = false
  actions :index

  controller do
    def scoped_collection
      super.where(dimension: 'ragpicker').where.not(pick_up_id: nil)
    end
  end


  index do
    column 'Payment' do |obj|
      obj.pick_up.payment_method
    end
    column :pincode do |obj|
      obj.pick_up.pincode
    end
    column :city do |obj|
      obj.pick_up.city
    end
    column :address do |obj|
      obj.pick_up.address
    end
    column :landmark do |obj|
      obj.pick_up.landmark
    end
    column "Pick Date" do |obj|
      obj.pick_up.start_time.strftime('%a %d %b') rescue nil
    end
    column "Time" do |obj|
      obj.pick_up.pick_time
    end

    column 'score', :stars

    column :comment

  end
end
