class AddOrderStatusToOrders < ActiveRecord::Migration[7.1]
  def change
    add_column :orders, :order_status, :string, default: "new"
  end
end
