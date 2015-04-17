begin
	require 'rspec/expectations';
rescue LoadError;
	require 'spec/expectations';
end
require 'cucumber/formatter/unicode'
$:.unshift(File.dirname(__FILE__) + '/../../lib')

Given(/^some tasks have been added to case$/) do
	create_exercises
	create_tasks
	create_task_texts
end

Given(/^a student has one task completed$/) do
	complete_task(Task.find(3), User.find(1))
end

When(/^"(.*?)" option is selected from case list$/) do |arg1|
	select(arg1, from:'exercise')
end

