json.array!(@players) do |player|
  json.extract! player, :id, :riotID, :name, :k, :d, :a, :cs, :triple, :quadra, :penta, :towers, :inhibs, :dragon, :baron
  json.url player_url(player, format: :json)
end
