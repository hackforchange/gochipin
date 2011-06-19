class HomeController < ApplicationController
  def index
    @events = Event.all
    @event = Event.new
  end
end
