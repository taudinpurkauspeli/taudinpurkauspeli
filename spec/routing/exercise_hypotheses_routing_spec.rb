require "rails_helper"

RSpec.describe ExerciseHypothesesController, :type => :routing do
  describe "routing" do

    it "routes to #index" do
      expect(:get => "/exercise_hypotheses").to route_to("exercise_hypotheses#index")
    end

    it "routes to #new" do
      expect(:get => "/exercise_hypotheses/new").to route_to("exercise_hypotheses#new")
    end

    it "routes to #show" do
      expect(:get => "/exercise_hypotheses/1").to route_to("exercise_hypotheses#show", :id => "1")
    end

    it "routes to #edit" do
      expect(:get => "/exercise_hypotheses/1/edit").to route_to("exercise_hypotheses#edit", :id => "1")
    end

    it "routes to #create" do
      expect(:post => "/exercise_hypotheses").to route_to("exercise_hypotheses#create")
    end

    it "routes to #update" do
      expect(:put => "/exercise_hypotheses/1").to route_to("exercise_hypotheses#update", :id => "1")
    end

    it "routes to #destroy" do
      expect(:delete => "/exercise_hypotheses/1").to route_to("exercise_hypotheses#destroy", :id => "1")
    end

  end
end
