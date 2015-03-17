begin
  require 'rspec/expectations';
rescue LoadError;
  require 'spec/expectations';
end
require 'cucumber/formatter/unicode'
$:.unshift(File.dirname(__FILE__) + '/../../lib')

Given(/^some tasks have been added to case$/) do
  create_exercises
  create_hypothesis_groups
  create_tasks
  create_task_texts
end

When(/^I choose a text task "(.*?)"$/) do |arg1|
  click_button(arg1)
end

Then(/^the task can be completed by clicking the button "(.*?)"$/) do |arg1|
  expect{
  	click_button(arg1)
  }.to change(CompletedTask, :count).by(1)
end
