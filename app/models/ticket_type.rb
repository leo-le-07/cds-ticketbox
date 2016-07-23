class TicketType < ActiveRecord::Base
  belongs_to :event

  validates_presence_of :event_id, :price, :name, :max_quantity, :min_in_order, :max_in_order
  validate :min_in_order_less_than_max_in_order
  validate :max_quantity_greater_than_min_in_order

  def min_in_order_less_than_max_in_order
    return if min_in_order.blank? || max_in_order.blank?
    if min_in_order > max_in_order
      errors.add(:min_in_order, "min_in_order can't greater then max_in_order")
    end
  end

  def max_quantity_greater_than_min_in_order
    return if max_quantity.blank? || min_in_order.blank?
    if max_quantity < min_in_order
      errors.add(:max_quantity, "max_quantity can't less then min_in_order")
    end
  end
end
