ActiveAdmin.register Zonal do
  menu label: 'Geo'
  form partial: 'form'

  index do
    column :zipcode
    column :lat
    column :lon
    column :city
    column :address
    actions
  end

  filter :city, as: :select, collection: ['Kolkata', 'Bengaluru', 'Mumbai']
  filter :zipcode
  filter :lat
  filter :lon
  filter :address

  show do
    attributes_table do
      row :zipcode
      row :lat
      row :lon
      row :city
      row :address
      row "Pricing" do
        zonal.pricing_zonals.map {|c| [c.category.name, c.price].join(': ') }.join(' | ')
      end
    end
  end

permit_params do
  [
    :zipcode,
    :lat,
    :lon,
    :city,
    :address,
    pricing_zonals_attributes: [
      :id,
      :_destroy,
      :price,
      :category_id
    ]
  ]
end


end
