ActiveAdmin.register Product do

  # See permitted parameters documentation:
  # https://github.com/activeadmin/activeadmin/blob/master/docs/2-resource-customization.md#setting-up-strong-parameters
  #
  # Uncomment all parameters which should be permitted for assignment
  #
  # permit_params :product_name, :description, :price, :stock_quantity, :image, :category_id
  #
  # or
  #
  # permit_params do
  #   permitted = [:product_name, :description, :price, :stock_quantity, :image, :category_id]
  #   permitted << :other if params[:action] == 'create' && current_user.admin?
  #   permitted
  # end

  ActiveAdmin.register Product do
    actions :index, :edit, :update, :create, :new, :destroy

    permit_params :product_name, :description, :price, :stock_quantity, :image, :category_id
  end

  index do
    selectable_column
    id_column
    column :product_name
    column :description
    column :price
    column :stock_quantity
    column :category_id
    column "Image" do |product|
      if product.image.attached?
        image_tag product.image.variant(resize_to_limit: [100, 100])
      else
        "No Image"
      end
    end
    actions
  end

  filter :product_name
  filter :stock_quantity
  filter :description
  filter :price
  filter :category_id

  form do |f|
    f.inputs 'Product Details' do
      f.input :product_name
      f.input :description
      f.input :price
      f.input :stock_quantity
      f.input :image, as: :file
      f.input :category, as: :select, collection: Category.all.collect { |c| [c.category_name, c.id] }
    end
    f.actions
  end

  show do
    attributes_table do
      row :product_name
      row :description
      row :price
      row :stock_quantity
      column :category_id
      row :image do |product|
        if product.image.attached?
          image_tag url_for(product.image), width: "50%"
        else
          "No image attached"
        end
      end
    end
  end


end
