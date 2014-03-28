json.array!(@tourneys) do |tourney|
  json.extract! tourney, :id, :state, :titulo
  json.url tourney_url(tourney, format: :json)
end
