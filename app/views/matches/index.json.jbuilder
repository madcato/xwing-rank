json.array!(@matches) do |match|
  json.extract! match, :id, :player1_id, :player2_id, :winner, :round_id
  json.url match_url(match, format: :json)
end
