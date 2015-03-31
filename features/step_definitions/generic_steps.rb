begin
  require 'rspec/expectations';
rescue LoadError;
  require 'spec/expectations';
end
require 'cucumber/formatter/unicode'
$:.unshift(File.dirname(__FILE__) + '/../../lib')

Given(/I have logged in as a student$/) do
  user = FactoryGirl.create(:user, admin: false)
  sign_in(username: "Testipoika", password: "Salainen1")
end

Given(/I have logged in as a teacher$/) do
  user = FactoryGirl.create(:user, admin: true)
  sign_in(username: "Testipoika", password: "Salainen1")
end

Given(/^I visit the "(.*?)" page of the case "(.*?)"$/) do |arg1, arg2|
  go_to_case(arg2)
  click_link(arg1)
  wait_for_ajax
end

When(/^I click on the link "(.*?)"$/) do |arg1|
  click_link(arg1)
  wait_for_ajax
end

When(/^I click on the button "(.*?)"$/) do |arg1|
  click_button(arg1)
  wait_for_ajax
end

Then(/^the page should show the content "(.*?)"$/) do |string|
  expect(page).to have_content string
end

Then(/the page should have button "(.*?)"$/) do |arg1|
	expect(page).to have_button arg1
end

Then(/^the caveman debug will happen$/) do
  save_and_open_page
end

