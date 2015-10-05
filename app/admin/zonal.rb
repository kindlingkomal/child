ActiveAdmin.register Zonal do

# See permitted parameters documentation:
# https://github.com/activeadmin/activeadmin/blob/master/docs/2-resource-customization.md#setting-up-strong-parameters
#
# permit_params :list, :of, :attributes, :on, :model
#
# or
#
permit_params do
  [
    :zipcode,
    :lat,
    :lon,
    :address,
  ]
end


end
