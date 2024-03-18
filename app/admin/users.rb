ActiveAdmin.register User do

  # See permitted parameters documentation:
  # https://github.com/activeadmin/activeadmin/blob/master/docs/2-resource-customization.md#setting-up-strong-parameters
  #
  # Uncomment all parameters which should be permitted for assignment
  #
  # permit_params :first_name, :last_name, :password_digest, :email, :address, :phone_number, :role
  #
  # or
  #
  # permit_params do
  #   permitted = [:first_name, :last_name, :password_digest, :email, :address, :phone_number, :role]
  #   permitted << :other if params[:action] == 'create' && current_user.admin?
  #   permitted
  # end

  ActiveAdmin.register User do
    actions :index, :edit, :update, :create, :new, :destroy

    permit_params :first_name, :last_name, :email, :address, :phone_number, :role
  end

end
