Feature:  View Static Pages
	In order to view pages
	As a visitor
	I must visit the page
	
	Scenario:  Visit Home Page
		Given I visit the Home Page at "/"
		Then I should see "Latest Posts"
		
	Scenario: Visit the About Page
		Given I visit the About Page at "/about"
		Then I should see "About Us"
		
	Scenario: Visit the Contact Page
		Given I visit the Contact page at "/contact"
		Then I should see "Contact Us"
		
	Scenario: Visit the Archives Page
		Given I visit the Archives Page at "/archives"
		Then I should see "Site Archives"