class CreateRankings < ActiveRecord::Migration
  def change
    create_table :rankings do |t|
      t.integer :player_id
      t.integer :points, :default => 0
      t.integer :breakpoints, :default => 0
      t.integer :sos, :default => 0

      t.timestamps
    end
  end
end
