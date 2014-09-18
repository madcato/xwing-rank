class AddColumnPublicIdToToruney < ActiveRecord::Migration
  def change
    add_column :tourneys, :publicId, :string
    
    add_index :tourneys, :publicId, unique: true
  end
end
