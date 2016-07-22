class OrdersController < ApplicationController
  def new
    @event = Event.find(params[:event_id])
    @order = @event.orders.new
    @event.ticket_types.each do |ticket_type|
      order_detail = @order.order_details.build
      order_detail.ticket_type = ticket_type
      order_detail.quantity = 0
      order_detail.price = ticket_type.price
      order_detail.total_price = 0
    end
  end

  def create
    redirect_to controller: "order_confirmation", action: "index", order_id: 1
  end
end
