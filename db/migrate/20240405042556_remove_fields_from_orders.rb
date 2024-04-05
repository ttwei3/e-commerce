class RemoveFieldsFromOrders < ActiveRecord::Migration[7.1]
  def change
    remove_column :orders, :guest_name, :string
    remove_column :orders, :email, :string
    remove_column :orders, :address, :string
    remove_column :orders, :order_status, :string
  end
end
