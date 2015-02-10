require "rails_helper"

RSpec.describe HypothesisGroupsController, :type => :routing do
  describe "routing" do

    it "routes to #new" do
      expect(:get => "/hypothesis_groups/new").to route_to("hypothesis_groups#new")
    end

    it "routes to #create" do
      expect(:post => "/hypothesis_groups").to route_to("hypothesis_groups#create")
    end

    it "routes to #destroy" do
      expect(:delete => "/hypothesis_groups/1").to route_to("hypothesis_groups#destroy", :id => "1")
    end

  end
end
