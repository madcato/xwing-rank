class AddSeedTypeColumnToTourney < ActiveRecord::Migration
  def change
    add_column :tourneys, :seedType, :integer, default: 1
  end
end
