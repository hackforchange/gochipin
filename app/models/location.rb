class Location
  include Mongoid::Document
  field :name
  field :address
  field :latitude
  field :longitude

  validates_presence_of :name, :address, :latitude, :longitude

  belongs_to :event
end
