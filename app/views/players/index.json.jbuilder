json.array!(@players) do |player|
  json.extract! player, :id, :riotID, :name, :k, :d, :a, :score
  json.url player_url(player, format: :json)
end
