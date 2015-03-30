require "rails_helper"

RSpec.describe MultichoicesController, :type => :routing do
  describe "routing" do

    it "routes to #index" do
      expect(:get => "/multichoices").to route_to("multichoices#index")
    end

    it "routes to #new" do
      expect(:get => "/multichoices/new").to route_to("multichoices#new")
    end

    it "routes to #show" do
      expect(:get => "/multichoices/1").to route_to("multichoices#show", :id => "1")
    end

    it "routes to #edit" do
      expect(:get => "/multichoices/1/edit").to route_to("multichoices#edit", :id => "1")
    end

    it "routes to #create" do
      expect(:post => "/multichoices").to route_to("multichoices#create")
    end

    it "routes to #update" do
      expect(:put => "/multichoices/1").to route_to("multichoices#update", :id => "1")
    end

    it "routes to #destroy" do
      expect(:delete => "/multichoices/1").to route_to("multichoices#destroy", :id => "1")
    end

    it "routes to #check_answers" do
      expect(:post => "/multichoices/1/check_answers").to route_to("multichoices#check_answers", :id => "1")
    end

  end
end
