json.array!(@log_entries) do |log_entry|
  json.extract! log_entry, :id, :user_id, :controller, :action, :params, :exercise_id, :task_id, :exhyp_ids, :datetime, :request_path, :ip, :method, :response_path
  json.url log_entry_url(log_entry, format: :json)
end
