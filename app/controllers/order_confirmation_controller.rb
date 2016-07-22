class OrderConfirmationController < ApplicationController
  def index
    @event = Event.find(1)
  end

  def show
  end
end
