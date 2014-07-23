class AddUserToTourney < ActiveRecord::Migration
  def change
    add_column :tourneys, :user_id, :integer
  end
end
