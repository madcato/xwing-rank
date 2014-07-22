json.array!(@players_tourneys) do |players_tourney|
  json.extract! players_tourney, :id, :player_id, :tourney_id
  json.url players_tourney_url(players_tourney, format: :json)
end
