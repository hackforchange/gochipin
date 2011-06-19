require 'spec_helper'

describe HomeController do

  describe "GET 'index'" do
    it "should be successful" do
      get :index
      response.should be_success
    end
    
    it "should assign event to @events" do
      event = Factory.build(:event)
      event.user = Factory(:user)
      event.location = Factory(:location)
      event.save!
      get :index
      assigns(:events).should eq([event])
    end  
  end

end
