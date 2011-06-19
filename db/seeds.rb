# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ :name => 'Chicago' }, { :name => 'Copenhagen' }])
#   Mayor.create(:name => 'Daley', :city => cities.first)
puts 'EMPTY THE MONGODB DATABASE'
Mongoid.master.collections.reject { |c| c.name =~ /^system/}.each(&:drop)

puts 'SETTING UP DEFAULT USER LOGIN'
user = User.create! :name => 'Jeff Remer', :email => 'jeff@threestarchina.com', :password => 'changeme', :password_confirmation => 'changeme'
puts 'New user created: ' << user.name

puts 'SETTING UP DEFAULT EVENTS'
event = Event.create!({
  :user => user,
  :title => "Mt. Sutro Trail Work Day",
  :when => "Next Saturday at 9am",
  :where => "100 Medical Center Way, San Francisco, CA"
})
puts 'New event created: ' << event.title

event = Event.create!({
  :user => user,
  :title => "Hack for Change",
  :when => "Today at noon",
  :where => "139 Townsend St. San Francisco, CA 94107"
})
puts 'New event created: ' << event.title



