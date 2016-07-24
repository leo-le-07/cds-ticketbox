class HomeController < ApplicationController
  def index
    @events = Event.where("status = 2")
  end
end
