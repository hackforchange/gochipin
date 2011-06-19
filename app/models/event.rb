class Event
  include Mongoid::Document
  include Geokit::Geocoders
  
  field :title, :type => String
  field :description, :type => String
  field :time, :type => Time
  
  validates_presence_of :title, :time, :location, :user

  has_one :location
  belongs_to :user

  def when=(fuzzy_time)
    self.time= Chronic.parse(fuzzy_time)
  end  

  def where=(address)
    place = MultiGeocoder.geocode(address)    
    self.location= Location.create!({
      :name => address,
      :address => address,
      :latitude => place.lat,
      :longitude => place.lng
    })
  end
end
