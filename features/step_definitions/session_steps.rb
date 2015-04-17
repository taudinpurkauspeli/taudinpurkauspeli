begin
  require 'rspec/expectations';
rescue LoadError;
  require 'spec/expectations';
end
require 'cucumber/formatter/unicode'
$:.unshift(File.dirname(__FILE__) + '/../../lib')

Given(/^I am not logged in$/) do
  #nothing
end

When(/^I fill in the form with correct values$/) do
  fill_in('user_username', with: 'Testikäyttäjä')
  fill_in('user_password', with: 'Nauta on koullut')
  fill_in('user_password_confirmation', with: 'Nauta on koullut')
  fill_in('user_realname', with: 'Teppo Testaaja')
  fill_in('user_email', with: 'nauta@on.koullut')
  fill_in('user_student_number', with: '000000000')
  fill_in('user_starting_year', with: 2000)
end

Given(/^I have a user account$/) do
  User.create username:'Testikäyttäjä', password:'Nauta on koullut', password_confirmation:'Nauta on koullut', realname:'Teppo Testaaja', email:'nauta@on.koullut', student_number: '000000000', starting_year: 2000
end

When(/^I enter my username and password$/) do
  fill_in('username', with: 'Testikäyttäjä')
  fill_in('password', with: 'Nauta on koullut')
end