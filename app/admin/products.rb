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

  form do |f|
    f.inputs 'Product Details' do
      f.input :product_name
      f.input :description
      f.input :price
      f.input :stock_quantity
      f.input :image, as: :file
      f.input :category, as: :select, collection: Category.all.collect { |c| [c.categoty_name, c.id] }
    end
    f.actions
  end

  show do
    attributes_table do
      row :image do |product|
        if product.image.attached?
          image_tag url_for(product.image), size: "150x150"
        else
          text_node "No image available"
        end
      end
    end
  end

end
