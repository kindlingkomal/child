ActiveAdmin.register Category do
  permit_params :name, :price, :image

  index do
    selectable_column
    # id_column
    column :name
    column :price
    column :image do |obj|
      image_tag obj.image.url(:thumbnail), class: 'thumbnail-img'
    end
    column :created_at
    actions
  end

  filter :name
  filter :price

  form do |f|
    f.inputs do
      f.input :name
      f.input :image
      f.input :price, label: 'Default price', :input_html => { :min => 0 }
      para "The value is used if we have not specified price in zone."
    end
    actions
  end

  show do
    attributes_table do
      row :name
      row :price
      row 'Image' do |obj|
        image_tag obj.image.url(:thumbnail), class: 'thumbnail-img'
      end
    end
  end

end
