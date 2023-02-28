class SetDefault < ActiveRecord::Migration[7.0]
  def change
    change_column :merchants, :status, :integer, default: 1
  end
end
