begin
	require 'rspec/expectations';
rescue LoadError;
	require 'spec/expectations';
end
require 'cucumber/formatter/unicode'
$:.unshift(File.dirname(__FILE__) + '/../../lib')

Given(/^cases and tasks have been created$/) do
	create_exercises
	create_tasks
end

When(/^I click on the fancy\-ass chevron up beside button "(.*?)"$/) do |arg1|
	task_id = Task.where(name: arg1).first.id
	button = find_by_id("tasks/" + task_id.to_s + "/up")

	button.click
	wait_for_ajax
end

When(/^I click on the down chevron beside button "(.*?)"$/) do |arg1|
	task_id = Task.where(name: arg1).first.id
	button = find_by_id("tasks/" + task_id.to_s + "/down")

	button.click
	wait_for_ajax

end

Then(/^the page should have the button "(.*?)" bottommost$/) do |arg1|
	buttons = all(:button)
	expect(buttons[5].value).to eq(arg1)
end

Then(/^the page should have the button "(.*?)" topmost$/) do |arg1|

	buttons = all(:button)
	expect(buttons[2].value).to eq(arg1)
end


