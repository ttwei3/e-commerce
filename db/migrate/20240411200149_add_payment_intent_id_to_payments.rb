class AddPaymentIntentIdToPayments < ActiveRecord::Migration[7.1]
  def change
    add_column :payments, :payment_intent_id, :string
  end
end
