class AddPointsFieldToMatches < ActiveRecord::Migration
  def change
    remove_column :matches, :winner
    add_column :matches, :points1, :integer
    add_column :matches, :points2, :integer
  end
end
