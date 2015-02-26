begin
  require 'rspec/expectations';
rescue LoadError;
  require 'spec/expectations';
end
require 'cucumber/formatter/unicode'
$:.unshift(File.dirname(__FILE__) + '/../../lib')

Given(/^Cases have been created$/) do
  create_exercises
end

When(/^I fill in task name$/) do
  fill_in('name', with: 'Soita asiakkaalle')
  end
When(/^I fill in task name and task text content$/) do
  fill_in('name', with: 'Soita asiakkaalle')
  fill_in('content', with: 'Soita asiakkaalle')
end

Then(/^new task should be in the database$/) do
  expect(Task.count).to eq(1)
  expect(TaskText.count).to eq(0)
  expect(Subtask.count).to eq(0)
end

Then(/^new task and task text should be in the database$/) do
  expect(Task.count).to eq(1)
  expect(TaskText.count).to eq(1)
  expect(Subtask.count).to eq(1)
end

