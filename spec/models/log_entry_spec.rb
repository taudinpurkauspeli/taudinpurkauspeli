require 'rails_helper'

RSpec.describe LogEntry, type: :model do
  it "has all parameters set correctly" do
    new_log_entry = LogEntry.new

    new_log_entry.user_id = 1
    new_log_entry.controller = "exercises"
    new_log_entry.action = "new"

    compressed_params = YAML::dump({id: 1, layout: true})
    new_log_entry.params = compressed_params

    new_log_entry.exercise_id = 2
    new_log_entry.task_id = 3

    compressed_exhyp_ids = YAML::dump([4, 5, 6])
    new_log_entry.exhyp_ids = compressed_exhyp_ids

    new_date = DateTime.current
    new_log_entry.datetime = new_date
    new_log_entry.request_path = "/exercises/new"
    new_log_entry.ip = "127.0.0.1"
    new_log_entry.method = "GET"

    new_log_entry.response_path = "/exercises/new/post"
    new_log_entry.flash_notice = "Oikein meni!"
    new_log_entry.flash_alert = "Valinnoissa oli vielä virheitä!"

    expect(new_log_entry.user_id).to eq(1)
    expect(new_log_entry.controller).to eq("exercises")
    expect(new_log_entry.action).to eq("new")
    expect(new_log_entry.params).to eq(compressed_params)
    expect(new_log_entry.exercise_id).to eq(2)
    expect(new_log_entry.task_id).to eq(3)
    expect(new_log_entry.exhyp_ids).to eq(compressed_exhyp_ids)
    expect(new_log_entry.datetime).to eq(new_date)
    expect(new_log_entry.request_path).to eq("/exercises/new")
    expect(new_log_entry.ip).to eq("127.0.0.1")
    expect(new_log_entry.method).to eq("GET")
    expect(new_log_entry.response_path).to eq("/exercises/new/post")
    expect(new_log_entry.flash_notice).to eq("Oikein meni!")
    expect(new_log_entry.flash_alert).to eq("Valinnoissa oli vielä virheitä!")

  end

  describe "with all correct parameters" do

    let!(:log_entry){FactoryGirl.create(:log_entry)}

    it "is saved" do
      expect(log_entry).to be_valid
      expect(LogEntry.count).to eq(1)
    end
  end
end
