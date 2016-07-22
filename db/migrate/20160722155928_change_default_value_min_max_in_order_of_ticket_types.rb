class ChangeDefaultValueMinMaxInOrderOfTicketTypes < ActiveRecord::Migration
  def change
    change_column_default :ticket_types, :min_in_order, 0
  end
end
