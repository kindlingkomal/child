ActiveAdmin.register PricingZonal do

# See permitted parameters documentation:
# https://github.com/activeadmin/activeadmin/blob/master/docs/2-resource-customization.md#setting-up-strong-parameters
#
# permit_params :list, :of, :attributes, :on, :model
#
# or
#
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
