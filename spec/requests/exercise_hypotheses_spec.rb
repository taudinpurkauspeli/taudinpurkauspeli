require 'rails_helper'

RSpec.describe "ExerciseHypotheses", :type => :request do
  describe "GET /exercise_hypotheses" do
    it "works! (now write some real specs)" do
      get exercise_hypotheses_path
      expect(response).to have_http_status(200)
    end
  end
end
