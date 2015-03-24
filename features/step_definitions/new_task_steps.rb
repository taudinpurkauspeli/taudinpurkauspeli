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
  fill_in('task_name', with: 'Soita asiakkaalle')
  end
When(/^I fill in task text content$/) do
  fill_in('task_text_content', with: 'Soita asiakkaalle puhelimella')
end

Then(/^new task should be in the database$/) do
  expect(Task.where(level:1...999).count).to eq(1)
  expect(TaskText.count).to eq(0)
  expect(Subtask.count).to eq(0)
end

Then(/^task text should be in the database$/) do
  expect(TaskText.count).to eq(1)
  expect(Subtask.count).to eq(1)
end

Then(/^page should show the new task text content$/) do
  expect(page).to have_content("Soita asiakkaalle puhelimella")
end

When(/^I fill in multichoice question$/) do
  fill_in('multichoice_question', with: 'Soitatko asiakkaalle puhelimella?')
end

Then(/^multichoice should be in the database$/) do
  expect(Multichoice.count).to eq(1)
  expect(Subtask.count).to eq(1)
end

When(/^I fill in option content$/) do
  fill_in('option_content', with: 'Soitan puhelimella')
end

When(/^I fill in option explanation$/) do
  fill_in('option_explanation', with: 'Puhelimella soittaminen on nyt hyvin järkevää.')
end

Then(/^option should be in the database$/) do
  expect(Option.count).to eq(1)
end
