class OrderConfirmationController < ApplicationController
  def index
    @event = Event.find(params[:event_id])
    @order = Order.find(params[:order_id])
  end

  def show
  end
end
