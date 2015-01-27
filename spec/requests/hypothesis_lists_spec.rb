require 'rails_helper'

RSpec.describe "HypothesisLists", :type => :request do
  describe "GET /hypothesis_lists" do
    it "works! (now write some real specs)" do
      get hypothesis_lists_path
      expect(response).to have_http_status(200)
    end
  end
end
