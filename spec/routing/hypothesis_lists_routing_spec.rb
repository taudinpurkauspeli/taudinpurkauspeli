require "rails_helper"

RSpec.describe HypothesisListsController, :type => :routing do
  describe "routing" do

    it "routes to #index" do
      expect(:get => "/hypothesis_lists").to route_to("hypothesis_lists#index")
    end

    it "routes to #new" do
      expect(:get => "/hypothesis_lists/new").to route_to("hypothesis_lists#new")
    end

    it "routes to #show" do
      expect(:get => "/hypothesis_lists/1").to route_to("hypothesis_lists#show", :id => "1")
    end

    it "routes to #edit" do
      expect(:get => "/hypothesis_lists/1/edit").to route_to("hypothesis_lists#edit", :id => "1")
    end

    it "routes to #create" do
      expect(:post => "/hypothesis_lists").to route_to("hypothesis_lists#create")
    end

    it "routes to #update" do
      expect(:put => "/hypothesis_lists/1").to route_to("hypothesis_lists#update", :id => "1")
    end

    it "routes to #destroy" do
      expect(:delete => "/hypothesis_lists/1").to route_to("hypothesis_lists#destroy", :id => "1")
    end

  end
end
