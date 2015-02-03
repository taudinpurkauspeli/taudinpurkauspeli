begin
  require 'rspec/expectations';
rescue LoadError;
  require 'spec/expectations';
end
require 'cucumber/formatter/unicode'
$:.unshift(File.dirname(__FILE__) + '/../../lib')

Given(/^I am on the front page with preexisting exercises which have tasks$/) do
  Exercise.create name:"Lihanautakuolemat", anamnesis:"Lihanautoja on kuollut"
  Task.create name:"Soita lääkärille"

  visit exercises_path
end