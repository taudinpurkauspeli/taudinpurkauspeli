begin
  require 'rspec/expectations';
rescue LoadError;
  require 'spec/expectations';
end
require 'cucumber/formatter/unicode'
$:.unshift(File.dirname(__FILE__) + '/../../lib')

Given(/^some text tasks have been added to case$/) do
  create_exercises
  create_tasks
  create_task_texts
end

Given(/^some multichoice tasks have been added to case$/) do
  create_exercises
  create_tasks
  create_multichoices
end

Given(/^some radiobutton tasks have been added to case$/) do
  create_exercises
  create_tasks
  create_radiobuttons
end

When(/^I choose a text task "(.*?)"$/) do |arg1|
  click_and_wait(arg1)
end

When(/^I choose a multichoice task "(.*?)"$/) do |arg1|
  click_and_wait(arg1)
end

When(/^I choose a radiobutton task "(.*?)"$/) do |arg1|
  click_and_wait(arg1)
end

When(/^I check the right options$/) do
  check 'checked_options_1'
  check 'checked_options_3'
end

When(/^I choose the right option$/) do
  choose 'checked_options_3'
end

When(/^I choose a wrong option$/) do
  choose 'checked_options_1'
end

When(/^I check wrong options$/) do
  check 'checked_options_1'
  check 'checked_options_2'
  check 'checked_options_3'
end

When(/^I don't check any options$/) do
end

When(/^I don't choose any option$/) do
end

When(/^I don't check all right options$/) do
  check 'checked_options_3'
end


Then(/^the task can be completed by clicking the button "(.*?)"$/) do |arg1|
  expect{
    click_button(arg1)
    wait_for_ajax
  }.to change(CompletedTask, :count).by(1)
end

Then(/^the task cannot be completed by clicking the button "(.*?)"$/) do |arg1|
  expect{
    click_and_wait(arg1)
  }.to change(CompletedTask, :count).by(0)
end


Then(/^I should see the message "(.*?)"$/) do |arg1|
  expect(page).to have_content arg1
end
