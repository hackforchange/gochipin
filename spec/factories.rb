require 'factory_girl'

Factory.define :user do |u|
  u.name { Factory.create(:name) }
  u.email { Factory.create(:email) }
  u.password 'please'
end

Factory.define :event do |e|
  e.title 'Test Event'
  e.description 'Something about this event'
  e.time  Time.new
end

Factory.define :location do |l|
  l.name "Change.org"
  l.address "139 Townsend St. San Francisco, CA 94107"
  l.latitude "37.780229"
  l.longitude "-122.390981"
end

Factory.sequence :name do |n|
   names = %w[ Joe Bob Sue ]
   "#{names[rand 3]} #{names[rand 3]} #{n}"
end

Factory.sequence :email do |n|
   names = %w[ Joe Bob Sue ]
   "#{names[rand 3]}#{n}@somewhere.com"
end