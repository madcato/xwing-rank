class AddNumberOfMatchesToRanking < ActiveRecord::Migration
  def change
    add_column :rankings, :numberOfMatches, :integer, default: 0 
  end
end
