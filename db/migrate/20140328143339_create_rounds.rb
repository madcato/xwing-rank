class CreateRounds < ActiveRecord::Migration
  def change
    create_table :rounds do |t|
      t.integer :order
      t.integer :tourney_id

      t.timestamps
    end
  end
end
