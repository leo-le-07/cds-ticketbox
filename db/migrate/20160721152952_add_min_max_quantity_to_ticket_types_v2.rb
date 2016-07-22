class AddMinMaxQuantityToTicketTypesV2 < ActiveRecord::Migration
  def change
    add_column :ticket_types, :min_in_order, :integer, default: 1
    add_column :ticket_types, :max_in_order, :integer, default: 10
  end
end
