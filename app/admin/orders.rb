ActiveAdmin.register Order do
  permit_params :user_id, :total_price, :province_id, :order_status

  index do
    selectable_column
    id_column
    column :created_at
    column "Customer", :user
    column :total_price
    column :province
    column :status do |order|
      status_tag order.order_status
    end
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
      row :status do |order|
        status_tag order.order_status
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

  action_item :ship, only: :show, if: proc { order.order_status != 'shipped' } do
    link_to 'Mark as Shipped', ship_admin_order_path(order), method: :put
  end

  member_action :ship, method: :put do
    order = Order.find(params[:id])
    order.update(order_status: 'shipped')
    redirect_to admin_order_path(order), notice: "Order marked as shipped."
  end

end
