begin
  require 'rspec/expectations';
rescue LoadError;
  require 'spec/expectations';
end
require 'cucumber/formatter/unicode'
$:.unshift(File.dirname(__FILE__) + '/../../lib')

When(/^I click on the link "(.*?)"$/) do |arg1|
  click_link(arg1)
end

When(/^I click on the button "(.*?)"$/) do |arg1|
  click_button(arg1)
end

# TODO join ^
When(/^I press "(.*?)"$/) do |arg1|
  click_button(arg1)
end

Then(/^the page should show the content "(.*?)"$/) do |string|
  expect(page).to have_content string
end

# TODO join ^
Then(/^page should have message: "(.*?)"$/) do |arg1|
  expect(page).to have_content arg1
end

Then(/the page should have button "(.*?)"$/) do |arg1|
	expect(page). to have_button arg1
end

Given(/I have logged in as a student$/) do
  user = FactoryGirl.create(:user, admin: false)

  sign_in(username: "Testipoika", password: "Salainen1")

end

Given(/I have logged in as a teacher$/) do
  user = FactoryGirl.create(:user, admin: true)
  sign_in(username: "Testipoika", password: "Salainen1")
end

Given(/^exercises have been added$/) do
  Exercise.create name:"Lihanautakuolemat", anamnesis:"Lihanautoja on menehtynyt lukuisia"
  Exercise.create name:"Heikko hevonen", anamnesis:"Hevosella on heikot polvet"

end

Given(/^there are exercises and hypothesis groups$/) do
  Exercise.create name:"Lihanautakuolemat", anamnesis:"Lihanautoja on menehtynyt lukuisia"
  Exercise.create name:"Heikko hevonen", anamnesis:"Hevosella on heikot polvet"

  HypothesisGroup.create name:"Nautataudit"
  HypothesisGroup.create name:"Hevostaudit"
end

Given(/^hypotheses have been created$/) do
  Hypothesis.create name:"Nautaflunssa", hypothesis_group_id:1
  Hypothesis.create name:"Hevosheikkous", hypothesis_group_id:2
end

Given(/^hypotheses have been added to case$/)  do
  Hypothesis.create name:"Nautaflunssa", hypothesis_group_id:1
  Hypothesis.create name:"Hevosheikkous", hypothesis_group_id:2
  ExerciseHypothesis.create exercise_id:1, hypothesis_id:1
end

Given(/^tasks have been added$/)  do
  Task.create name:"Soita lääkärille"
  Task.create name:"Lääkitse hevonen"
end