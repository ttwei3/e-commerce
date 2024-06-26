ActiveAdmin.register Category do

  # See permitted parameters documentation:
  # https://github.com/activeadmin/activeadmin/blob/master/docs/2-resource-customization.md#setting-up-strong-parameters
  #
  # Uncomment all parameters which should be permitted for assignment
  #
  # permit_params :category_name
  #
  # or
  #
  # permit_params do
  #   permitted = [:category_name]
  #   permitted << :other if params[:action] == 'create' && current_user.admin?
  #   permitted
  # end
  ActiveAdmin.register Category do
    actions :index, :edit, :update, :create, :new, :destroy

    permit_params :category_name
  end

  filter :category_name
end
