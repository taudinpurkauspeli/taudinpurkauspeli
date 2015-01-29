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

And(/^I click on the link "(.*?)"$/) do |arg1|
  click_link(arg1)
end

Given(/^I do fill in all the fields with correct input values$/) do
  fill_in('exercise_name', with: 'Lihanautakuolemat')
  fill_in('exercise_anamnesis', with: 'Nauta on koullut')

end

Given(/^I do not fill in all the fields with correct input values$/) do
  fill_in('exercise_name', with: '')
  fill_in('exercise_anamnesis', with: 'Nauta on koullut')

end

When(/^I press "(.*?)"$/) do |arg1|
  click_button(arg1)
end

Then(/^page should have message: "(.*?)"$/) do |arg1|
  expect(page).to have_content arg1
end


And(/^the exercise should be in the database$/) do
  expect(Exercise.count).to eq(1)
end

And(/^the exercise should not be in the database$/) do
  expect(Exercise.count).to eq(0)
end