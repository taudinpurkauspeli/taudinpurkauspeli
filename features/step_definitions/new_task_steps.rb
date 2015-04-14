begin
  require 'rspec/expectations';
rescue LoadError;
  require 'spec/expectations';
end
require 'cucumber/formatter/unicode'
$:.unshift(File.dirname(__FILE__) + '/../../lib')

Given(/^Cases have been created$/) do
  create_exercises
end

Given(/^Task with a multichoice has been created$/) do
  create_tasks
  create_multichoices
end

Given(/^Task with a radiobutton has been created$/) do
  create_tasks
  create_radiobuttons
end

Given(/^Task with interview has been created$/) do
  create_tasks
  create_interviews
end

When(/^I fill in task name$/) do
  fill_in('task_name', with: 'Soita asiakkaalle')
end

When(/^I fill in task text content$/) do
  fill_in('task_text_content', with: 'Soita asiakkaalle puhelimella')
end

When(/^I fill in interview title$/) do
  fill_in('interview_title', with: 'Lisätietoa puhelimella')
end

When(/^I fill in question title and content$/) do
  fill_in('question_title', with: 'Onko hygieniasta huolehdittu')
  fill_in('question_content', with: 'Käsiä on pesty aina kun on muistettu')
end

When(/^I go to the multichoice edit page$/) do
  click_and_wait('Soita lääkärille')
  click_and_wait('Monivalintakysymys: Tykkääkö koira nappuloista?')
  end

When(/^I go to the radiobutton edit page$/) do
  click_and_wait('Soita lääkärille')
  click_and_wait('Monivalintakysymys: Kenelle pitää soittaa?')
end

When(/^I go to the interview edit page$/) do
  click_and_wait('Soita lääkärille')
  click_and_wait('Haastattelu')
end

When(/^I fill in multichoice question$/) do
  fill_in('multichoice_question', with: 'Soitatko asiakkaalle puhelimella?')
  end

When(/^I fill fill in radiobutton question and select radiobutton option$/) do
  fill_in('multichoice_question', with: 'Onko tauti epidemia?')
  check 'multichoice_is_radio_button'
end

When(/^I fill in option content$/) do
  fill_in('option_content', with: 'Soitan puhelimella')
end

When(/^I fill in option explanation$/) do
  fill_in('option_explanation', with: 'Puhelimella soittaminen on nyt hyvin järkevää.')
end

When(/^I fill in option content, explanation and select right answer box$/) do
  fill_in('option_content', with: 'On')
  fill_in('option_explanation', with: 'Epidemia on yleinen.')
  select('Pakollinen', from:'option[is_correct_answer]')
end


Then(/^new task should be in the database$/) do
  expect(Task.where(level:1...999).count).to eq(1)
  expect(TaskText.count).to eq(0)
  expect(Subtask.count).to eq(0)
end

Then(/^task text should be in the database$/) do
  expect(TaskText.count).to eq(1)
  expect(Subtask.count).to eq(1)
end

Then(/^page should show the new task text content$/) do
  expect(page).to have_button("Teksti: Soita asiakkaalle puhelimella")
end

Then(/^page should show the new interview title$/) do
  expect(page).to have_selector("input[value='Lisätietoa puhelimella']")
end

Then(/^page should show the new question title$/) do
  save_and_open_page
  expect(page).to have_selector("input[value='Lisätietoa puhelimella']")
end

Then(/^multichoice should be in the database$/) do
  expect(Multichoice.count).to eq(1)
  expect(Subtask.count).to eq(1)
end

Then(/^radiobutton should be in the database$/) do
  expect(Multichoice.count).to eq(1)
  expect(Multichoice.first.is_radio_button).to eq(true)
  expect(Subtask.count).to eq(1)
end

Then(/^interview should be in the database$/) do
  expect(Interview.count).to eq(1)
  expect(Subtask.count).to eq(1)
end

Then(/^question should be in the database$/) do
  expect(Question.count).to eq(1)
  expect(Question.last.title).to eq('Onko hygieniasta huolehdittu')
  end

Then(/^option should be in the database$/) do
  expect(Option.count).to eq(5)
  expect(Option.last.content).to eq('Soitan puhelimella')
  end

Then(/^right radiobutton option should be in the database$/) do
  expect(Option.count).to eq(4)
  expect(Option.last.content).to eq('On')
  expect(Option.last.explanation).to eq('Epidemia on yleinen.')
end
