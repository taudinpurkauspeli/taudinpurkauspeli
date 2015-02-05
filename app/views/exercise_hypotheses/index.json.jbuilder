json.array!(@exercise_hypotheses) do |exercise_hypothesis|
  json.extract! exercise_hypothesis, :id, :exercise_id, :hypothesis_id, :explanation
  json.url exercise_hypothesis_url(exercise_hypothesis, format: :json)
end
