Given(/^I visit the login page at "(.*?)"$/) do |arg1|
  visit(arg1)
end

When(/^I fill out the form with the following credentials:$/) do |table|
  # table is a Cucumber::Ast::Table
	puts table.rows_hash
	credentials = table.rows_hash.each do |field, value|
		fill_in field, :with => value
	end
end

When(/^I click the Log In button$/) do
  click_button('Log In')
end

Then(/^I click the "(.*?)" link$/) do |arg1|
  click_link(arg1, match: :first)
end

Then(/^I visit the home page at "(.*?)"$/) do |arg1|
  visit(arg1)
end
