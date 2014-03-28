class CreateTourneys < ActiveRecord::Migration
  def change
    create_table :tourneys do |t|
      t.integer :state
      t.string :titulo

      t.timestamps
    end
  end
end
