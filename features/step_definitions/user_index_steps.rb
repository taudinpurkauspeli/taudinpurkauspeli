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

Given(/^students have created accounts$/) do
	create_students
end

Given(/^a student has one task completed$/) do
	complete_task(Task.find(3), User.find(1))
end

Given(/^students have completed tasks$/) do
	complete_task(Task.find(3), User.find(2))
	complete_task(Task.find(5), User.find(3))
end

When(/^"(.*?)" option is selected from case list$/) do |arg1|
	select(arg1, from:'exercise')
end

When(/^I select "(.*?)" to be shown$/) do |arg1|
	select(arg1, from:'list_type')
end

Then(/^the page should show all students$/) do
	expect(page).to have_content(User.find(2).first_name)
	expect(page).to have_content(User.find(3).first_name)
	expect(page).to have_content(User.find(4).first_name)
	expect(page).to have_content(User.find(2).last_name)
	expect(page).to have_content(User.find(3).last_name)
	expect(page).to have_content(User.find(4).last_name)
end

