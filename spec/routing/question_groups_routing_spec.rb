require "rails_helper"

RSpec.describe QuestionGroupsController, :type => :routing do
  describe "routing" do

    it "routes to #index" do
      expect(:get => "/question_groups").to route_to("question_groups#index")
    end

    it "routes to #new" do
      expect(:get => "/question_groups/new").to route_to("question_groups#new")
    end

    it "routes to #show" do
      expect(:get => "/question_groups/1").to route_to("question_groups#show", :id => "1")
    end

    it "routes to #edit" do
      expect(:get => "/question_groups/1/edit").to route_to("question_groups#edit", :id => "1")
    end

    it "routes to #create" do
      expect(:post => "/question_groups").to route_to("question_groups#create")
    end

    it "routes to #update" do
      expect(:put => "/question_groups/1").to route_to("question_groups#update", :id => "1")
    end

    it "routes to #destroy" do
      expect(:delete => "/question_groups/1").to route_to("question_groups#destroy", :id => "1")
    end

  end
end
