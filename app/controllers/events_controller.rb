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
    @regions = Region.all
  end

  def update
    @event = Event.find(params[:id])
    @event.save
    if @event.update(event_params)
      flash[:success] = "Cập nhật thành công"
      redirect_to @event
    else
      flash.now[:error] = @event.errors.full_messages.to_sentence
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
    @regions = Region.all
  end

  def create
    @event = current_user.events.new(event_params)
    if @event.save
      redirect_to event_ticket_types_path(@event)
    else
      flash[:notice] = @event.errors.full_messages.to_sentence
      redirect_to :back
    end
  end

  def search
    @events = Event.search_by_name(params[:name])
  end

  def publish
    @event = Event.find(params[:id])
    if @event.draft?
      ticket_types = @event.ticket_types.where("status = 1")
      if ticket_types.size > 0
        @event.status = 2
        @event.save
        flash[:success] = "Công khai sự kiện thành công"
      else
        flash[:notice] = "Vui lòng tạo thông tin vé cho sự kiện này"
      end
    else
      flash[:notice] = "Sự kiện đã được công khai"
    end
    redirect_to :back
  end

  private
    def event_params
      params.require(:event).permit(:name, :hero_image_url, :extended_html_description, :starts_at, :ends_at, :category_id, venue_attributes: [:name, :full_address, :region_id])
    end

    def get_date(date_name, hash)
      date = DateTime.new(hash["#{date_name}(1i)"].to_i, hash["#{date_name}(2i)"].to_i,
        hash["#{date_name}(3i)"].to_i, hash["#{date_name}(4i)"].to_i, hash["#{date_name}(5i)"].to_i)
    end
end
