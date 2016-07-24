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
    @event = Event.find(params[:event_id])
    @order = @event.orders.new(order_params)
    @order.order_number = Order.generate_order_number
    @order.total_price = 0
    @order.order_details.each_with_index do |od, index|
      od.price = TicketType.find(od.ticket_type_id).price
      od.total_price = od.quantity * od.price
      @order.total_price += od.total_price
    end
    if @order.save
      OrderConfirmMailer.send_confirmation(@order).deliver
      redirect_to controller: "order_confirmation", action: "index", order_id: @order.id, event_id: @event.id
    else
      flash.now[:error] = "Có lỗi xảy ra trong quá trình tạo đơn hàng #{@order.errors.full_messages.to_sentence}"
      render 'new'
    end
  end

  private
    def order_params
      params.require(:order).permit(:name, :address, :email, :phone, :total_price, order_details_attributes: [:ticket_type_id, :quantity, :price])
    end
end
