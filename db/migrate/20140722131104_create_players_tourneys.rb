class CreatePlayersTourneys < ActiveRecord::Migration
  def change
    create_table :players_tourneys do |t|
      t.integer :player_id
      t.integer :tourney_id

      t.timestamps
    end
  end
end
