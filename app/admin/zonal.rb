ActiveAdmin.register Zonal do
  form partial: 'form'

  show do
    attributes_table do
      row :zipcode
      row :lat
      row :lon
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
