begin
  require 'rspec/expectations';
rescue LoadError;
  require 'spec/expectations';
end
require 'cucumber/formatter/unicode'
$:.unshift(File.dirname(__FILE__) + '/../../lib')

Given(/^I have completed some tasks$/) do
  complete_task(Task.find(3), User.find(1))
  complete_task(Task.find(5), User.find(1))
end

Given(/^I go to see my own page$/) do
  visit user_path(User.find(1))
end

Then(/^the page should show my information$/) do
  expect(page).to have_content(User.find(1).first_name)
  expect(page).to have_content(User.find(1).last_name)
  expect(page).to have_content(User.find(1).username)
  expect(page).to have_content(User.find(1).email)
  expect(page).to have_content(User.find(1).student_number)
  expect(page).to have_content(User.find(1).starting_year)
  expect(page).to have_content("Ei aloitettuja caseja!")
end

Then(/^I should see my progress$/) do
  expect(page).to have_content("50")
  expect(page).to have_content("100")

  expect(page).to have_content("Lihanautakuolemat")
  expect(page).to have_content("Heikko hevonen")
end

