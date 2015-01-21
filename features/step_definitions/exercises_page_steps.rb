begin
  require 'rspec/expectations';
rescue LoadError;
  require 'spec/expectations';
end
require 'cucumber/formatter/unicode'
$:.unshift(File.dirname(__FILE__) + '/../../lib')

Given(/^no exercises have been added$/) do

end

When(/^I go to the page that shows exercises$/) do
  visit exercises_path
end

Then(/^the page should show the content "(.*?)"$/) do |string|
  expect(page).to have_content string
end