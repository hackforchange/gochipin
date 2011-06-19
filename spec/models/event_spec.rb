require 'spec_helper'

describe Event do
  before(:each) do 
    attendees = 5.times.collect{Factory(:user)}
    @attr = {
      :title => "My Event",
      :description => "A description",
      :time => Time.new,
      :user => Factory(:user),
      :attendees => [attendees],
      :location => Factory(:location)
    }
  end
  
  it "should create a new instance given a valid attribute" do
    Event.create!(@attr)
  end
  
  it "should require a title" do
    no_title_event = Event.new(@attr.merge(:title => ""))
    no_title_event.should_not be_valid
  end
  
  it "should require a time" do
    no_time_event = Event.new(@attr.merge(:time => ""))
    no_time_event.should_not be_valid
  end

  it "should require a user" do
    no_user_event = Event.new(@attr.merge(:user => ""))
    no_user_event.should_not be_valid
  end  
  
  it "should require a location or where" do
    no_location_event = Event.new(@attr.merge(:location => nil))
    no_location_event.should_not be_valid
  end  
  
  it "should create a new instance given fuzzy attributes" do
    event = Event.create!({
      :user => @attr[:user],
      :title => @attr[:title],
      :when => "Next Saturday at 9am",
      :where => "139 Townsend St. San Francisco, CA 94107"
    })
    event.location.should_not be_nil
  end
  
  it "can be represented as a geoJson feature" do
    event = Event.create!({
      :user => @attr[:user],
      :title => @attr[:title],
      :when => "Next Saturday at 9am",
      :where => "139 Townsend St. San Francisco, CA 94107"
    })
    event.to_feature.should eq({      
      :id => event.id,
      :type => "Feature",
      :geometry => {
        :type => "Point",
        :coordinates => [event.location.longitude, event.location.latitude],
        :properties => {
          :title => event.title,
          :address => event.location.address,
          :time => event.time
        }
      }
    })
  end
end
