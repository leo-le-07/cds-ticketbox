class EventsController < ApplicationController
  before_action :deny_anonymous_user, only: [:new]

  def index
    @events = current_user.events.all
  end

  def show
    @event = Event.find(params[:id])
  end

  def edit
    @event = current_user.events.find(params[:id])
  end

  def new
    @event = Event.new
  end
end
