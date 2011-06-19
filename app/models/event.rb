class Event
  include Mongoid::Document
  include Geokit::Geocoders
  
  field :title, :type => String
  field :description, :type => String
  field :time, :type => Time
  
  validates_presence_of :title, :time, :user

  has_one :location, :dependent => :destroy
  belongs_to :user
  
  after_save :assign_location

  alias :when :time
  def when=(fuzzy_time)
    self.time= Chronic.parse(fuzzy_time)
  end  

  alias :where :location
  def where=(address)
    @address = address
  end
  

  private
  
    def assign_location
      if @address
        place = MultiGeocoder.geocode(@address)    
        self.location= Location.create!({
          :name => @address,
          :address => @address,
          :latitude => place.lat,
          :longitude => place.lng
        })
      end
    end  
end
