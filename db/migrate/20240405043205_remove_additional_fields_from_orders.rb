class RemoveAdditionalFieldsFromOrders < ActiveRecord::Migration[7.1]
  def change
    remove_column :orders, :city, :string
    remove_column :orders, :postal_code, :string
    remove_column :orders, :phone_number, :string
  end
end
