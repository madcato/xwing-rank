class AddLastNameToPlayers < ActiveRecord::Migration
  def change
    rename_column :players, :name, :firstName
    add_column :players, :lastName, :string
  end
end
