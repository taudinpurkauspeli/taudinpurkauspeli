json.array!(@hypothesis_lists) do |hypothesis_list|
  json.extract! hypothesis_list, :id, :hypothesis_id, :exercise_id, :explanation
  json.url hypothesis_list_url(hypothesis_list, format: :json)
end
