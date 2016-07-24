module OrderConfirmationHelper
  def order_details_info(order)
    result = ""
    order.order_details.each do |od|
      if od.quantity > 0
        result << "#{od.quantity} x #{od.ticket_type.name}, "
      end
    end
    result = result.chop.chop if result.size > 0
    result
  end
end
