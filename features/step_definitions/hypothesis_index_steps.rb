begin
  require 'rspec/expectations';
rescue LoadError;
  require 'spec/expectations';
end
require 'cucumber/formatter/unicode'
$:.unshift(File.dirname(__FILE__) + '/../../lib')

Given(/^some hypotheses have been added to case$/) do
  create_exercises
  create_hypothesis_groups

  create_hypotheses

  add_hypothesis_to_case(exercise_id: 1, hypothesis_id: 1, explanation: "Nauta oli kipeä", task_id:1)
  add_hypothesis_to_case(exercise_id: 1, hypothesis_id: 2, explanation: "Hevonen oli kipeä", task_id:1)
end

Given(/^cases and hypothesis groups have been created$/) do
  create_exercises
  create_hypothesis_groups
end

Given(/^cases, hypothesis groups and hypotheses have been created$/) do
  create_all_hypotheses_for_case
end

Given(/^hypotheses with prerequisite tasks have been added to case$/) do
  create_exercises
  create_hypothesis_groups
  create_tasks
  create_hypotheses
  add_hypothesis_to_case(exercise_id: 1, hypothesis_id: 1, explanation: "Nauta katkesi keskeltä", task_id:1)
  add_hypothesis_to_case(exercise_id: 1, hypothesis_id: 2, explanation: "Hevonen katkesi keskeltä", task_id:1)
end

Given(/^I have completed all the tasks$/) do
  Task.all.each do |task|
    CompletedTask.create user_id:1, task_id:task.id
  end
end

When(/^I click on a button "(.*?)"$/) do |arg1|
	first(:button, arg1).click
end

When(/^I click on button "(.*?)"$/) do |arg1|
 all(:button, 'Tallenna')[2].click
end

When(/^I fill in the hypothesis name field with a correct value$/) do
	fill_in('hypothesis_name', with: 'Suu- ja sorkkatauti', :match => :prefer_exact)
end

When(/^I fill in the hypothesis name field with an incorrect value$/) do
	fill_in('hypothesis_name', with: '', :match => :prefer_exact)
end

When(/^I save the new hypothesis with button "(.*?)"$/) do |arg1|
  all(:button, 'Tallenna')[0].click
  end

When(/^I save changes with button "(.*?)"$/) do |arg1|
  all(:button, 'Päivitä')[0].click
end

When(/^I click on the delete button "(.*?)"$/) do |arg1|
  all(:button, 'Poista casesta')[0].click
end

When(/^I click on the hypothesis button "(.*?)"$/) do |arg1|
   click_button(arg1)
end

When(/^I click on one of the hypotheses of the case$/) do
  click_button('Hevosheikkous')
end

When(/^I fill in the hypothesis group name field with a correct name$/) do
    fill_in('hypothesis_group_name', with: 'Koirasairaudet', :match => :prefer_exact)
end

When(/^I fill in the explanation field$/) do
  fill_in('exercise_hypothesis_explanation', with: 'Hevosen hauraat luut', :match => :prefer_exact)
end

Given(/^I try to visit the "(.*?)" page of the case "(.*?)"$/) do |arg1, arg2|
  visit hypotheses_path
end





Then(/^the hypothesis should be added to the case$/) do
	e = Exercise.first
	expect(e.hypotheses.first.name).to eq('Hevosheikkous')
	expect(page).to have_button 'Hevosheikkous'
  expect(ExerciseHypothesis.count).to eq(1)
end

Then(/^the new hypothesis group should be created$/) do
  expect(page).to have_button 'Koirasairaudet'
  expect(HypothesisGroup.count).to eq(3)
 end

Then(/^the explanation should be added to the hypothesis$/) do
  expect(ExerciseHypothesis.find(2).explanation).to include('Hevosen hauraat luut')
end

Then(/^the hypothesis should be removed from the case$/) do
  exercise_hypotheses = Exercise.first.exercise_hypotheses
  expect(exercise_hypotheses.count).to eq(1)
  expect(exercise_hypotheses.first.hypothesis.name).not_to eq("Hevosheikkous")
end

Then(/^the new hypothesis should be created$/) do
  expect(page).to have_button 'Suu- ja sorkkatauti'
  hypothesis_group = HypothesisGroup.first
  expect(hypothesis_group.hypotheses.first.name).to eq('Suu- ja sorkkatauti')
  expect(Hypothesis.count).to eq(1)
end

Then(/^the new hypothesis should not be created$/) do
  expect(Hypothesis.count).to eq(0)
end

Then(/^the page should have buttons$/) do |table|
  table.raw.each do |row|
    row.each do |content|
      expect(page).to have_button content
    end
  end
end

Then(/^"(.*?)" should be checked from exercise$/) do |arg1|
  expect(User.first.checked_hypotheses.first.exercise_hypothesis.hypothesis.name).to eq(arg1)
  expect(User.first.checked_hypotheses.count).to eq(1)
end


Then(/^"(.*?)" should not be checked from exercise$/) do |arg1|
  expect(User.first.checked_hypotheses.count).to eq(0)
end


Then(/^I should be redirected back to the front page$/) do
  expect(current_path).to eq(exercises_path)
end