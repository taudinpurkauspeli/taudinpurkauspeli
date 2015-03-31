require "rails_helper"

RSpec.describe SubtasksController, :type => :routing do
  describe "routing" do

    it "routes to #index" do
      expect(:get => "/subtasks").to route_to("subtasks#index")
    end

    it "routes to #new" do
      expect(:get => "/subtasks/new").to route_to("subtasks#new")
    end

    it "routes to #show" do
      expect(:get => "/subtasks/1").to route_to("subtasks#show", :id => "1")
    end

    it "routes to #edit" do
      expect(:get => "/subtasks/1/edit").to route_to("subtasks#edit", :id => "1")
    end

    it "routes to #create" do
      expect(:post => "/subtasks").to route_to("subtasks#create")
    end

    it "routes to #update" do
      expect(:put => "/subtasks/1").to route_to("subtasks#update", :id => "1")
    end

    it "routes to #destroy" do
      expect(:delete => "/subtasks/1").to route_to("subtasks#destroy", :id => "1")
    end

  end
end
