class CreateCoupon < ActiveRecord::Migration[7.0]
  def change
    create_table :coupons do |t|
      t.string :coupon
      t.integer :amount_off

      t.timestamps
    end
  end
end
