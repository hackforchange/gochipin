class Event
  include Mongoid::Document
  include Geokit::Geocoders
  
  field :title, :type => String
  field :description, :type => String
  field :time, :type => Time
  
  validates_presence_of :title, :time, :user
  validate :has_where_or_location

  has_one :location, :dependent => :destroy
  belongs_to :user
  has_many :attendees, :class_name => 'User'
  
  after_save :assign_location

  alias :when :time
  def when=(fuzzy_time)
    self.time= Chronic.parse(fuzzy_time)
  end  

  alias :where :location
  def where=(address)
    @address = address
  end
  
  def to_feature
    {      
      :id => id,
      :type => "Feature",
      :geometry => {
        :type => "Point",
        :coordinates => [location.longitude, location.latitude],
        :properties => {
          :title => title,
          :address => location.address,
          :time => time
        }
      }
    }
  end
  

  LOG = Logger.new(STDOUT)
  def sms(to_number)
  account = Twilio::RestAccount.new(ENV['TWILIO_SID'], ENV['TWILIO_KEY'])
  LOG.debug("SID #{ENV['TWILIO_SID']}")
    t = {
        'From' => '+14155992671',
        'To'   => to_number,
        'Body' => "2803-5593 #{user.name} want to share #{title} with you!"
    }
    url = "/2010-04-01/Accounts/#{ENV['TWILIO_SID']}/SMS/Messages"
    resp = account.request(url, "POST", t)
    LOG.debug("SENT SMS------------")
    LOG.debug(url)
    LOG.debug(resp.inspect)
    LOG.debug(resp.body)
  end

  private

    def has_where_or_location
      unless (@address or location)
        errors.add :base, "An event location is required."
      end
    end
  
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
