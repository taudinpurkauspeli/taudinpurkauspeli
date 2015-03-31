require "rails_helper"

RSpec.describe CompletedTasksController, :type => :routing do
  describe "routing" do

    it "routes to #create" do
      expect(:post => "/completed_tasks").to route_to("completed_tasks#create")
    end

  end
end
