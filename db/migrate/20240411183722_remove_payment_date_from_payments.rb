class RemovePaymentDateFromPayments < ActiveRecord::Migration[7.1]
  def change
    remove_column :payments, :payment_date, :datetime
  end
end
