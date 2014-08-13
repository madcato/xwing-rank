class AddDroppedToInscription < ActiveRecord::Migration
  def change
    add_column :rankings, :dropped, :boolean
  end
end
