Given(/^I visit the Home Page at "(.*?)"$/) do |arg1|
  visit(arg1)
end


Given(/^I visit the About Page at "(.*?)"$/) do |arg1|
  visit(arg1)
end

Given(/^I visit the Contact page at "(.*?)"$/) do |arg1|
  visit(arg1)
end

Given(/^I visit the Archives Page at "(.*?)"$/) do |arg1|
  visit(arg1)
end

Then(/^I should see "(.*?)"$/) do |arg1|
  page.has_content?(arg1)
end