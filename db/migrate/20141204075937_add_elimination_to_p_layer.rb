class AddEliminationToPLayer < ActiveRecord::Migration
  def change
    add_column :rankings, :eliminated, :bool, default: false
    
    add_index :rankings, :eliminated
  end
end
