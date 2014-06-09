Given(/^I visit the installation page at "(.*?)"$/) do |arg1|
  visit(arg1)
end

When(/^I click the Save Account button$/) do
  click_button("Save Account")
end
