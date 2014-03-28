json.array!(@players) do |player|
  json.extract! player, :id, :name, :uniqueid, :numberOfMatches, :ranking
  json.url player_url(player, format: :json)
end
