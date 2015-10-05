ActiveAdmin.register PricingZonal do


permit_params do
  [
    :category,
    :zonal,
    :category_id,
    :zonal_id,
    :category_name,
    :start_date,
    :end_date,
    :price,
  ]
end


end
