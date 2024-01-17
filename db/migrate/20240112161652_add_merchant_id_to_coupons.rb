class AddMerchantIdToCoupons < ActiveRecord::Migration[7.0]
  def change
    add_reference :coupons, :merchant, null: false, foreign_key: true
  end
end
