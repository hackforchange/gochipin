require 'spec_helper'

describe Location do
  before(:each) do 
    @attr = {
      :name => "Change.org",
      :address => "139 Townsend St. San Francisco, CA 94107",
      :latitude => "37.780229",
      :longitude => "-122.390981"
    }
  end
  
  it "should create a new instance given a valid attribute" do
    Location.create!(@attr)
  end
  
  it "should require a name" do
    no_name_location = Location.new(@attr.merge(:name => ""))
    no_name_location.should_not be_valid
  end
  
  it "should require an address" do
    no_address_location = Location.new(@attr.merge(:address => ""))
    no_address_location.should_not be_valid
  end

  it "should require a latitude" do
    no_latitude_location = Location.new(@attr.merge(:latitude => ""))
    no_latitude_location.should_not be_valid
  end

  it "should require a longitude" do
    no_longitude_location = Location.new(@attr.merge(:longitude => ""))
    no_longitude_location.should_not be_valid
  end
end
