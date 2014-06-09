Feature:  Installation
	In order to start using the site
	As a user
	I must visit the install page
	To create the first user

	@first_run
	Scenario:  Create User
		Given I visit the installation page at "/install"
		When I fill out the form with the following credentials:
			| name									| Exit Status One					|
			| email									| brent@exitstatusone.com |
			| password 							| password								|
			| password_confirmation |	password								|
		And I click the Save Account button
		Then I should see "All changes saved."

