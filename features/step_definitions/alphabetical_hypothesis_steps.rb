begin
	require 'rspec/expectations';
rescue LoadError;
	require 'spec/expectations';
end
require 'cucumber/formatter/unicode'
$:.unshift(File.dirname(__FILE__) + '/../../lib')

Given(/^there is an exercise that has multiple hypotheses$/) do
	Exercise.create name:"Lihanautakuolemat", anamnesis:"Lihanautoja on menehtynyt lukuisia"

  createSomeHypotheses()	

	HypothesisGroup.create name:"Taudit", id:1

	for i in 1..3
		ExerciseHypothesis.create exercise_id:1, hypothesis_id:i
	end
end

Given(/^I go to the hypothesis list of that exercise$/) do
	visit exercises_path
	click_button('Lihanautakuolemat')
	click_link('Työhypoteesit')
	wait_for_ajax
end

Given(/^those hypotheses are all checked$/) do
  for i in 1..3
    CheckedHypothesis.create exercise_hypothesis_id:i, user_id:1
  end
end

Given(/^there are multiple hypotheses that are not added to any exercise$/) do
  createSomeHypotheses()  
end

Then(/^the hypothesis list should be in alphabetical order$/) do
	actual = all("input[type='submit']")[1].value
	expect( actual ).to eq('Aivokuume')
	actual = all("input[type='submit']")[2].value
	expect( actual ).to eq('Nautaflunssa')
	actual = all("input[type='submit']")[3].value
	expect( actual ).to eq('Sikatartunta')
end

Then(/^the checked hypothesis list should be in alphabetical order$/) do
	actual = all("input[type='button']")[1].value
	expect( actual ).to eq('Aivokuume')
	actual = all("input[type='button']")[2].value
	expect( actual ).to eq('Nautaflunssa')
	actual = all("input[type='button']")[3].value
	expect( actual ).to eq('Sikatartunta')
end