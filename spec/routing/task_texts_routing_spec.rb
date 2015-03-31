require "rails_helper"

RSpec.describe TaskTextsController, :type => :routing do
  describe "routing" do

    it "routes to #index" do
      expect(:get => "/task_texts").to route_to("task_texts#index")
    end

    it "routes to #new" do
      expect(:get => "/task_texts/new").to route_to("task_texts#new")
    end

    it "routes to #show" do
      expect(:get => "/task_texts/1").to route_to("task_texts#show", :id => "1")
    end

    it "routes to #edit" do
      expect(:get => "/task_texts/1/edit").to route_to("task_texts#edit", :id => "1")
    end

    it "routes to #create" do
      expect(:post => "/task_texts").to route_to("task_texts#create")
    end

    it "routes to #update" do
      expect(:put => "/task_texts/1").to route_to("task_texts#update", :id => "1")
    end

    it "routes to #destroy" do
      expect(:delete => "/task_texts/1").to route_to("task_texts#destroy", :id => "1")
    end

    it "routes to #check_answers" do
      expect(:post => "/task_texts/1/check_answers").to route_to("task_texts#check_answers", :id => "1")
    end

  end
end
