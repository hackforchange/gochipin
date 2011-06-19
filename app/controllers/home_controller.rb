class HomeController < ApplicationController
  def index
    @events = Event.all
    @features = @events.collect{|e| e.to_feature}.to_json
    @event = Event.new
  end
end
