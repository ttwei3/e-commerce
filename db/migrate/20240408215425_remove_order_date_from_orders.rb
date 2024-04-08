class RemoveOrderDateFromOrders < ActiveRecord::Migration[7.1]
  def change
    remove_column :orders, :order_date, :datetime
  end
end
