class CreateResults < ActiveRecord::Migration
  def change
    create_table :results do |t|
      t.integer :player_id
      t.integer :score
      t.integer :match_id

      t.timestamps
    end
    
    remove_column :matches, :points1
    remove_column :matches, :points2
    remove_column :matches, :player1_id
    remove_column :matches, :player2_id
  end
end
