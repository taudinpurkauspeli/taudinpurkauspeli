json.array!(@hypotheses) do |hypothesis|
  json.extract! hypothesis, :id, :name
  json.url hypothesis_url(hypothesis, format: :json)
end
