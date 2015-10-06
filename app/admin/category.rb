ActiveAdmin.register Category do

  form do |f|
    f.inputs do
      f.input :name
      f.input :image
      f.input :price, label: 'Default price', :input_html => { :min => 0 }
      para "The value is used if we have not specified price in zone."
    end
    actions
  end

permit_params do
  [
    :name,
    :price,
    :image,
  ]
end


end