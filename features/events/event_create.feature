Feature: Create Event
	In order to create an Event
	A user
	Should be able to create an Event
	
	Scenario: User is logged in and on the homepage
		Given I am a new, authenticated user
		When I follow "Create Event"
	
