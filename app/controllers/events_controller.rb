class EventsController < ApplicationController
  before_action :deny_anonymous_user, only: [:new]

  def index
    @events = current_user.events.all
  end

  def show
    @event = Event.find(params[:id])
  end

  def edit
    @section = "event-info"
    @event = current_user.events.find(params[:id])
    @categories = Category.all
  end

  def update
    @event = Event.find(params[:id])
    @event.category.update(event_params[:category_attributes])
    @event.venue.update(event_params[:venue_attributes])
    @event.venue.region.update(event_params[:venue_attributes][:region_attributes])
    @event.starts_at = get_date("starts_at", params[:event])
    @event.ends_at = get_date("ends_at", params[:event])
    @event.save
    if @event.update(event_params)
      redirect_to @event
    else
      render action: 'edit'
    end
  end

  def new
    @section = "event-info"
    @event = Event.new
    @event.venue = Venue.new
    @event.venue.region = Region.first
    @event.category = Category.first
    @categories = Category.all
  end

  def create
    @event = Event.new(event_params)
    @event.category = Category.find(event_params[:category_attributes][:id])
    @event.venue = Venue.new(name: event_params[:venue_attributes][:name], full_address: event_params[:venue_attributes][:full_address], region_id: event_params[:venue_attributes][:region_attributes][:id])
    @event.starts_at = get_date("starts_at", params[:event])
    @event.ends_at = get_date("ends_at", params[:event])
    @event.venue.save
    @event.venue_id = @event.venue.id
    @event.save
    byebug
    redirect_to @event
  end

  def search
    @events = Event.search_by_name(params[:name])
  end

  private
    def event_params
      params.require(:event).permit(:name, :hero_image_url, :extended_html_description, venue_attributes: [:name, :full_address, region_attributes: [:id]], category_attributes: [:id])
    end

    def get_date(date_name, hash)
      date = DateTime.new(hash["#{date_name}(1i)"].to_i, hash["#{date_name}(2i)"].to_i,
        hash["#{date_name}(3i)"].to_i, hash["#{date_name}(4i)"].to_i, hash["#{date_name}(5i)"].to_i)
    end
end
