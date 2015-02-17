begin
  require 'rspec/expectations';
rescue LoadError;
  require 'spec/expectations';
end
require 'cucumber/formatter/unicode'
$:.unshift(File.dirname(__FILE__) + '/../../lib')

Given(/^user has not logged in$/) do
  #nothing
end

Given(/^no exercises have been added$/) do
  #hehe
end

When(/^I go to the page that shows exercises$/) do
  visit exercises_path
end

When(/^I go to the front page$/) do
  visit exercises_path
end