begin
  require 'rspec/expectations';
rescue LoadError;
  require 'spec/expectations';
end
require 'cucumber/formatter/unicode'
$:.unshift(File.dirname(__FILE__) + '/../../lib')

Given(/^some text tasks have been added to case$/) do
  create_exercises
  create_hypothesis_groups
  create_tasks
  create_task_texts
end

Given(/^some multichoice tasks have been added to case$/) do
  create_exercises
  create_hypothesis_groups
  create_tasks
  create_multichoices
end

When(/^I choose a text task "(.*?)"$/) do |arg1|
  click_button(arg1)
end

When(/^I choose a multichoice task "(.*?)"$/) do |arg1|
  click_button(arg1)
end

When(/^I check the right options$/) do
  check 'checked_options_1'
  check 'checked_options_3'
end

When(/^I check wrong options$/) do
  check 'checked_options_1'
  check 'checked_options_2'
  check 'checked_options_3'
end

When(/^I don't check any options$/) do
  check 'checked_options_3'
end

When(/^I don't check all right options$/) do
end


Then(/^the task can be completed by clicking the button "(.*?)"$/) do |arg1|
  expect{
    click_button(arg1)
  }.to change(CompletedTask, :count).by(1)
end

Then(/^the task cannot be completed by clicking the button "(.*?)"$/) do |arg1|
  expect{
    click_button(arg1)
  }.to change(CompletedTask, :count).by(0)
end


Then(/^I should see the message "(.*?)"$/) do |arg1|
  expect(page).to have_content arg1
end
