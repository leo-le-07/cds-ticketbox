class TicketTypesController < ApplicationController
  before_action :deny_anonymous_user

  def index
    @section = "ticket-info"
    @event = Event.find(params[:event_id])
    @ticket_types = @event.ticket_types.where("status = 1")
  end

  def new
    @event = Event.find(params[:event_id])
    @ticket_type = @event.ticket_types.new
  end

  def edit
    @event = Event.find(params[:event_id])
    @ticket_type = @event.ticket_types.where("id = ? AND status = 1", params[:id]).first
  end

  def update
    @event = Event.find(params[:event_id])
    @ticket_type = TicketType.find(params[:id])
    @ticket_type.update(ticket_type_params)
    redirect_to event_ticket_types_path(@event)
  end

  def create
    @event = Event.find(params[:event_id])
    @ticket_type = @event.ticket_types.new(ticket_type_params)
    if @ticket_type.save
      redirect_to event_ticket_types_path(@event)
    else
      flash.now[:error] = @ticket_type.full_messages.to_sentence
      render 'new'
    end
  end

  def destroy
    @event = Event.find(params[:event_id])
    ticket_type = TicketType.find(params[:id])
    ticket_type.status = -1
    ticket_type.save
    redirect_to event_ticket_types_path(@event)
  end

  private
    def ticket_type_params
      params.require(:ticket_type).permit(:name, :price, :max_quantity, :min_in_order, :max_in_order)
    end
end
