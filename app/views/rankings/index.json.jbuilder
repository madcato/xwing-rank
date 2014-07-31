json.array!(@rankings) do |ranking|
  json.extract! ranking, :id, :player_id, :points, :breakpoints, :sos
  json.url ranking_url(ranking, format: :json)
end
