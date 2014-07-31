class AddTourneyToRankings < ActiveRecord::Migration
  def change
    add_column :rankings, :tourney_id, :integer
  end
end
