class AddMinMaxQuantityToTicketTypes < ActiveRecord::Migration
  def change
    add_column :users, :min_in_order, :integer
    add_column :users, :max_in_order, :integer
  end
end
