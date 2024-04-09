ActiveAdmin.register Order do
  permit_params :user_id, :total_price, :province_id

  index do
    selectable_column
    id_column
    column :created_at
    column "Customer", :user
    column :total_price
    column :province
    actions
  end

  show do
    attributes_table do
      row :id
      row :created_at
      row :user
      row :province
      row "Products Total Price" do |order|
        number_to_currency(order.items_total_price)
      end
      row "Total Tax" do |order|
        number_to_currency(order.calculate_total_tax)
      end
      row "Grand Total (Including Taxes)" do |order|
        number_to_currency(order.total_price)
      end
    end

    panel "Order Items" do
      table_for order.order_items do
        column :product
        column :quantity
        column "Payment Amount per Item" do |item|
          number_to_currency(item.payment_amount)
        end
        column "Total Price" do |item|
          number_to_currency(item.quantity * item.payment_amount)
        end
      end
    end
  end


end
