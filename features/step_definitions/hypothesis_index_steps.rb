begin
  require 'rspec/expectations';
rescue LoadError;
  require 'spec/expectations';
end
require 'cucumber/formatter/unicode'
$:.unshift(File.dirname(__FILE__) + '/../../lib')

 #Given(/^I am on the front page with preexisting exercises which have hypotheses$/) do
  #Exercise.create name:"Lihanautakuolemat", anamnesis:"Lihanautoja on kuollut"
  #Hypothesis.create name:"Nautaflunssa"

 # visit exercises_path
#end


When(/^I click on a button "(.*?)"$/) do |arg1|
	first(:button, arg1).click
end


When(/^I click on button "(.*?)"$/) do |arg1|
 all(:button, 'Tallenna')[2].click
end

When(/^I click on corresponding button "(.*?)"$/) do |arg1|
   all(:button, 'Päivitä')[0].click
end


When(/^I fill in name field with correct value$/) do
	fill_in('hypothesis_name', with: 'Suu- ja sorkkatauti', :match => :prefer_exact)
end

When(/^I click on the corresponding button "(.*?)"$/) do |arg1|
	first(:button, arg1).click
end


When(/^I click on a hypothesis button$/) do
   click_button('Hevosheikkous')
end

When(/^I click on one of the hypotheses of the case$/) do
  click_button('Nautaflunssa')
end

When(/^I fill in the name field with a correct name$/) do
    fill_in('hypothesis_group_name', with: 'Koirasairaudet', :match => :prefer_exact)
end

When(/^I navigate to the hypotheses page$/) do
    fill_in('hypothesis_group_name', with: 'Koirasairaudet', :match => :prefer_exact)
end

When(/^I fill in the explanation field$/) do
  fill_in('exercise_hypothesis_explanation', with: 'Hevosen hauraat luut', :match => :prefer_exact)
end

Then(/^the hypothesis should be added to the case$/) do
	e = Exercise.first
	expect(e.hypotheses.first.name).to eq('Hevosheikkous')
	#this should be revisited sometime
	save_and_open_page
	expect(page).to have_button 'Hevosheikkous'
end

Then(/^the new hypothesis group should be created$/) do
  expect(page).to have_button 'Koirasairaudet'
end

Then(/^the explanation should be added to the hypothesis$/) do
  expect(ExerciseHypothesis.first.explanation).to include('Hevosen hauraat luut')
end

Then(/^the hypothesis should be removed from the case$/) do
  e = ExerciseHypothesis.first
  expect(e).to eq(nil)
end


Then(/^the new hypothesis should be created$/) do
  expect(page).to have_button 'Suu- ja sorkkatauti'
  hg = HypothesisGroup.first
  expect(hg.hypotheses.first.name).to eq('Suu- ja sorkkatauti')
end