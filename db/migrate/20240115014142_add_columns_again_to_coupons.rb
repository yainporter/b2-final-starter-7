class AddColumnsAgainToCoupons < ActiveRecord::Migration[7.0]
  def change
    add_column :coupons, :status, :integer, default: 1
    add_column :coupons, :transactions, :integer
  end
end
