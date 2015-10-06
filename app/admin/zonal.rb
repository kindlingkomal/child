ActiveAdmin.register Zonal do
  form partial: 'form'


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
