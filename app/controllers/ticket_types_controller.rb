class TicketTypesController < ApplicationController
  before_action :deny_anonymous_user

  def index
    @event = Event.find(params[:event_id])
    @ticket_types = @event.ticket_types
  end

  def new
    @event = Event.find(params[:event_id])
    @ticket_type = @event.ticket_types.new
  end

  def edit
    @event = Event.find(params[:event_id])
    @ticket_type = @event.ticket_types.find(params[:id])
  end

  def destroy
  end
end
