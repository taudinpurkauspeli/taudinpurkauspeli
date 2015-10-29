begin
  require 'rspec/expectations';
rescue LoadError;
  require 'spec/expectations';
end
require 'cucumber/formatter/unicode'
$:.unshift(File.dirname(__FILE__) + '/../../lib')

Given(/^I am on the front page$/) do
  visit exercises_path
end

Given(/^I fill in all the fields with correct input values$/) do
  fill_in('exercise_name', with: 'Lihanautakuolemat')
  fill_in_ckeditor 'exercise_anamnesis', with: 'Nauta on koullut'
end

Given(/^I do not fill in all the fields with correct input values$/) do
  fill_in('exercise_name', with: '')
  fill_in_ckeditor 'exercise_anamnesis', with: 'Nauta on koullut'
end

When(/^I press the button "(.*?)"$/) do |arg1|
  wait_and_trigger_click(arg1)
end

Then(/^page should have a message: "(.*?)"$/) do |arg1|
  expect(page).to have_content arg1
end

Then(/^the exercise should be in the database$/) do
  expect(Exercise.count).to eq(1)
end

Then(/^the exercise should not be in the database$/) do
  expect(Exercise.count).to eq(0)
end
