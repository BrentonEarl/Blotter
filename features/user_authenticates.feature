Feature: User Authenticates
	In order to be authenticated
	Or in order to be deauthenticated
	As a user
	I must log in
	Or I must Log out
	
	@post_install
	Scenario: Log in and Log Out
		Given I visit the login page at "/login"
		When I fill out the form with the following credentials:
			| email			| brent@exitstatusone.com |
			| password 	| password								|
		And I click the Log In button
		Then I should see "Welcome,"
		And I visit the home page at "/"
		And I click the "Sign Out" link
		Then I should see "You are Signed out."	
