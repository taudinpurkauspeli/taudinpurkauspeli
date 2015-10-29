begin
  require 'rspec/expectations';
rescue LoadError;
  require 'spec/expectations';
end
require 'cucumber/formatter/unicode'
$:.unshift(File.dirname(__FILE__) + '/../../lib')

Given(/^some text tasks have been added to case$/) do
  create_exercises
  create_tasks
  create_task_texts
end

Given(/^some multichoice tasks have been added to case$/) do
  create_exercises
  create_tasks
  create_multichoices
end

Given(/^some radiobutton tasks have been added to case$/) do
  create_exercises
  create_tasks
  create_radiobuttons
  end

Given(/^some interview tasks have been added to case$/) do
  create_exercises
  create_tasks
  create_interviews
end

When(/^I choose a text task "(.*?)"$/) do |arg1|
  wait_and_trigger_click(arg1)
end

When(/^I choose a multichoice task "(.*?)"$/) do |arg1|
  wait_and_trigger_click(arg1)
end

When(/^I choose a radiobutton task "(.*?)"$/) do |arg1|
  wait_and_trigger_click(arg1)
end

When(/^I choose an interview task "(.*?)"$/) do |arg1|
  wait_and_trigger_click(arg1)
end

When(/^I check the right options$/) do
  check 'checked_options_1'
  check 'checked_options_3'
end

When(/^I check the right and some allowed options$/) do
  check 'checked_options_1'
  check 'checked_options_3'
  check 'checked_options_4'
end

When(/^I choose the right option$/) do
  choose 'checked_options_3'
end

When(/^I choose a wrong option$/) do
  choose 'checked_options_2'
end

When(/^I choose an allowed option$/) do
  choose 'checked_options_1'
end

When(/^I check wrong options$/) do
  check 'checked_options_1'
  check 'checked_options_2'
  check 'checked_options_3'
end

When(/^I don't check any options$/) do
end

When(/^I don't choose any option$/) do
end

When(/^I don't check all right options$/) do
  check 'checked_options_3'
  check 'checked_options_4'
end

When(/^I ask the required questions$/) do
  wait_and_trigger_click('ask_question_1')
  wait_and_trigger_click('ask_question_3')
end

When(/^I ask the required and some allowed questions$/) do
  wait_and_trigger_click('ask_question_1')
  wait_and_trigger_click('ask_question_3')
  wait_and_trigger_click('ask_question_4')
end

When(/^I ask the required and some wrong questions$/) do
  wait_and_trigger_click('ask_question_1')
  wait_and_trigger_click('ask_question_3')
  wait_and_trigger_click('ask_question_2')
end

When(/^I don't ask any questions$/) do
end


Then(/^the task can be completed by clicking the button "(.*?)"$/) do |arg1|
  expect{
    click_button(arg1)
    wait_for_ajax
  }.to change(CompletedTask, :count).by(1)
end

Then(/^the task cannot be completed by clicking the button "(.*?)"$/) do |arg1|
  expect{
    wait_and_trigger_click(arg1)
  }.to change(CompletedTask, :count).by(0)
end


Then(/^I should see the message "(.*?)"$/) do |arg1|
  expect(page).to have_content arg1
end

Then(/^I should see the explanations for wrong options$/) do
  expect(page).to have_content "Juuri oikea vastaus"
  expect(page).to have_content "Ei oikea vastaus"
  expect(page).to have_content "Toinen oikea vastaus"
  expect(page).not_to have_content "Melkein oikea vastaus"
end

Then(/^I should see the explanations for checked options$/) do
  expect(page).to have_content "Toinen oikea vastaus"
  expect(page).to have_content "Melkein oikea vastaus"
  expect(page).not_to have_content "Juuri oikea vastaus"
  expect(page).not_to have_content "Ei oikea vastaus"
end

Then(/^I should see the explanation for wrong option$/) do
  expect(page).to have_content "Ei oikea vastaus"
  expect(page).not_to have_content "Melkein oikein"
  expect(page).not_to have_content "Oikea vastaus"
end

Then(/^I should see the explanation for allowed option$/) do
  expect(page).to have_content "Melkein oikein"
  expect(page).not_to have_content "Ei oikea vastaus"
  expect(page).not_to have_content "Oikea vastaus"
end
