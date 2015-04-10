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

Given(/^some task texts have been added to case$/) do
	create_exercises
	create_tasks
	create_task_texts
end

Given(/^some multichoices have been added to case$/) do
	create_exercises
	create_tasks
	create_multichoices
end

Given(/^some radiobuttons have been added to case$/) do
	create_exercises
	create_tasks
	create_radiobuttons
end

Given(/^one task with text task is completed$/) do
	complete_subtask(Subtask.find(1), User.find(1))
	complete_task(Task.find(3), User.find(1))
end

Given(/^one task with multichoice is completed$/) do
	complete_subtask(Subtask.find(2), User.find(1))
	complete_task(Task.find(4), User.find(1))
end

Given(/^one task with radiobutton is completed$/) do
	complete_subtask(Subtask.find(2), User.find(1))
	complete_task(Task.find(4), User.find(1))
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
	expect(buttons[4].value).to eq(arg1)
end

Then(/^the page should have the button "(.*?)" topmost$/) do |arg1|
	buttons = all(:button)
	expect(buttons[1].value).to eq(arg1)
end

Then(/^the page should show the task text content$/) do
	expect(page).to have_content 'Lääkäri kertoo mikä on totuus'
end

Then(/^the page should show the information about completed multichoice$/) do
	expect(page).to have_content "Bakteerilääke"
	expect(page).to have_content "Astmalääke"
	expect(page).to have_content "Kurkkulääke"
	expect(page).to have_content "Ei oikea vastaus"
	expect(page).to have_content "Melkein oikea vastaus"
	expect(page).to have_content "Juuri oikea vastaus"
end

Then(/^the page should show the information about completed radiobutton$/) do
	expect(page).to have_content "Bakteerilääke"
	expect(page).to have_content "Astmalääke"
	expect(page).to have_content "Kurkkulääke"
	expect(page).to have_content "Melkein oikein"
	expect(page).to have_content "Ei oikea vastaus"
	expect(page).to have_content "Oikea vastaus"
end


