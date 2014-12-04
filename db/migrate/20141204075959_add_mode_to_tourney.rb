class AddModeToTourney < ActiveRecord::Migration
  def change
    add_column :tourneys, :mode, :integer, default: 1  # 1 = Swiss, 2 = Single Elimination
  end
end
