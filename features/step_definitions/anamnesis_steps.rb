begin
  require 'rspec/expectations';
rescue LoadError;
  require 'spec/expectations';
end
require 'cucumber/formatter/unicode'
$:.unshift(File.dirname(__FILE__) + '/../../lib')

Given(/^I am on the front page with preexisting exercises which have anamneses$/) do
  Exercise.create name:"Lihanautakuolemat", anamnesis:"Lihanautoja on menehtynyt lukuisia"
  visit exercises_path
end