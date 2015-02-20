class AddEliminationToPLayer < ActiveRecord::Migration
  def change
    add_column :rankings, :eliminated, :boolean, default: false
    
    add_index :rankings, :eliminated
  end
end
