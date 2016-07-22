class DropMinMaxOrderInUsers < ActiveRecord::Migration
  def change
    remove_column :users, :min_in_order
    remove_column :users, :max_in_order
  end
end
