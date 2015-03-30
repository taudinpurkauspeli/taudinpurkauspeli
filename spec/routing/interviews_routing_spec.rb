require "rails_helper"

RSpec.describe InterviewsController, :type => :routing do
  describe "routing" do

    it "routes to #index" do
      expect(:get => "/interviews").to route_to("interviews#index")
    end

    it "routes to #new" do
      expect(:get => "/interviews/new").to route_to("interviews#new")
    end

    it "routes to #show" do
      expect(:get => "/interviews/1").to route_to("interviews#show", :id => "1")
    end

    it "routes to #edit" do
      expect(:get => "/interviews/1/edit").to route_to("interviews#edit", :id => "1")
    end

    it "routes to #create" do
      expect(:post => "/interviews").to route_to("interviews#create")
    end

    it "routes to #update" do
      expect(:put => "/interviews/1").to route_to("interviews#update", :id => "1")
    end

    it "routes to #destroy" do
      expect(:delete => "/interviews/1").to route_to("interviews#destroy", :id => "1")
    end

    it "routes to #check_answers" do
      expect(:post => "/interviews/1/check_answers").to route_to("interviews#check_answers", :id => "1")
    end

    it "routes to #ask_question" do
      expect(:post => "/interviews/1/ask_question").to route_to("interviews#ask_question", :id => "1")
    end
  end
end
