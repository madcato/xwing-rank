class AddIndexToModels < ActiveRecord::Migration
  def change
    # add_index :rankings, [:player_id, :tourney_id]
    # add_index :matches, [:player1_id, :player2_id]
    
    # add_index :players, :ranking, order: { ranking: :desc}
#     add_index :rankings, [:points, :breakpoints, :sos], order: { points: :desc, breakpoints: :desc, sos: :desc}
#     add_index :rounds, :order, order: { order: :asc}
#
#     add_index :players, :name, unique: true
#     add_index :tourneys, :titulo, unique: true
#     add_index :players_tourneys, [:tourney_id, :player_id], unique: true
#     add_index :rounds, [:tourney_id, :order], unique: true
  end
end
