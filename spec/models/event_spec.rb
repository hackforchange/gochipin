require 'spec_helper'

describe Event do
  before(:each) do 
    @attr = {
      :title => "My Event",
      :description => "A description",
      :time => Time.new,
      :user => Factory(:user),
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
  
  it "should require a location" do
    no_location_event = Event.new(@attr.merge(:location => nil))
    no_location_event.should_not be_valid
  end  
end
