require "rails_helper"

RSpec.describe CheckedHypothesesController, :type => :routing do
  describe "routing" do

    it "routes to #new" do
      expect(:get => "/checked_hypotheses/new").to route_to("checked_hypotheses#new")
    end

    it "routes to #create" do
      expect(:post => "/checked_hypotheses").to route_to("checked_hypotheses#create")
    end

    it "routes to #destroy" do
      expect(:delete => "/checked_hypotheses/1").to route_to("checked_hypotheses#destroy", :id => "1")
    end

  end
end
