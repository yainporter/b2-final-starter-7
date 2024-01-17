class AddColumnToInvoice < ActiveRecord::Migration[7.0]
  def change
    add_reference :invoices, :coupon, null: true, foreign_key: true
    remove_column :coupons, :transactions, :integer
  end
end
