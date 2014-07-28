json.array!(@results) do |result|
  json.extract! result, :id, :player_id, :score, :match_id
  json.url result_url(result, format: :json)
end
