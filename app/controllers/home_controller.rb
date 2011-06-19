class HomeController < ApplicationController
  def index
    @events = Event.all
    @features = @events.collect{|e| e.to_feature}.to_json
    @event = Event.new
    geoip = Geokit::Geocoders::MultiGeocoder.geocode(request.remote_ip)
    @user_location = (geoip.city and geoip.state) ? "#{geoip.city}, #{geoip.state}" : "San Francisco, CA"
  end
  
  def about
    
  end
end
