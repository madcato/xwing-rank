class AddByeToInscribedPlayer < ActiveRecord::Migration
  def change
    add_column :rankings, :bye, :boolean, :default => false
  end
end
