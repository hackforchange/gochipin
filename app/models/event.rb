class Event
  include Mongoid::Document
  field :title, :type => String
  field :description, :type => String
  field :time, :type => Time
  
  validates_presence_of :title, :time, :user, :location
  has_one :location
  belongs_to :user
end
