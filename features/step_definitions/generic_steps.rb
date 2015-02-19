begin
  require 'rspec/expectations';
rescue LoadError;
  require 'spec/expectations';
end
require 'cucumber/formatter/unicode'
$:.unshift(File.dirname(__FILE__) + '/../../lib')

When(/^I click on the link "(.*?)"$/) do |arg1|
  click_link(arg1)
end

When(/^I click on the button "(.*?)"$/) do |arg1|
  click_button(arg1)
end

# TODO join ^
When(/^I press "(.*?)"$/) do |arg1|
  click_button(arg1)
end

Then(/^the page should show the content "(.*?)"$/) do |string|
  expect(page).to have_content string
end

# TODO join ^
Then(/^page should have message: "(.*?)"$/) do |arg1|
  expect(page).to have_content arg1
end

Then(/the page should have button "(.*?)"$/) do |arg1|
	expect(page). to have_button arg1
end

Given(/I have logged in as a student$/) do
  user = FactoryGirl.create(:user, admin: false)

  sign_in(username: "Testipoika", password: "Salainen1")

end

Given(/I have logged in as a teacher$/) do
  user = FactoryGirl.create(:user, admin: true)
  sign_in(username: "Testipoika", password: "Salainen1")
end

Given(/^exercises have been added$/) do
  create_exercises
end


Given(/^hypotheses have been created$/) do
  create_hypotheses
end

Given(/^tasks have been added$/)  do
  create_tasks
end