begin
  require 'rspec/expectations';
rescue LoadError;
  require 'spec/expectations';
end
require 'cucumber/formatter/unicode'
$:.unshift(File.dirname(__FILE__) + '/../../lib')

Given(/^no exercises have been added$/) do
  #hehe
end

Given(/^exercises have been added$/) do
  create_exercises
end

Given(/^exercise "(.*?)" has been hidden$/) do |arg1|
  (Exercise.find_by name:arg1).update(hidden:true)
end

When(/^I go to the page that shows exercises$/) do
  visit exercises_path
end

When(/^I go to the front page$/) do
  visit exercises_path
end

When(/^I click on the duplication button of case "(.*?)"$/) do |arg1|
  wait_and_trigger_click('exercises/1/dup')
end

Then(/^I should see the following buttons$/) do |table|
  table.raw.each do |row|
    row.each do |content|
      expect(page).to have_button content
    end
  end
end

Then(/^the case should be duplicated$/) do
  expect(page).to have_content("Casen kopioiminen onnistui!")
  expect(Exercise.count).to eq(3)
end