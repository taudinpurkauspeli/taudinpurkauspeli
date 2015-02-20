begin
  require 'rspec/expectations';
rescue LoadError;
  require 'spec/expectations';
end
require 'cucumber/formatter/unicode'
$:.unshift(File.dirname(__FILE__) + '/../../lib')

Given(/^some tasks have been added to case$/) do
  create_tasks
end

When(/^I choose a text task "(.*?)"$/) do |arg1|
  click_button(arg1)
end


