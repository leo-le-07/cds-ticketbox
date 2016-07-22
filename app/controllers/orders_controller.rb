class OrdersController < ApplicationController
  def new
    @event = Event.find(params[:event_id])
    @order = @event.orders.new
  end
end
