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

When(/^I go to the page that shows exercises$/) do
  visit exercises_path
end

When(/^I go to the front page$/) do
  visit exercises_path
end

Then(/^I should see the following buttons$/) do |table|
  table.raw.each do |row|
    row.each do |content|
      expect(page).to have_button content
    end
  end
end