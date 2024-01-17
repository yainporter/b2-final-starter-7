class AddColumnsToCoupons < ActiveRecord::Migration[7.0]
  def change
    add_column :coupons, :unique_code, :string
    add_column :coupons, :percent, :boolean
  end
end
