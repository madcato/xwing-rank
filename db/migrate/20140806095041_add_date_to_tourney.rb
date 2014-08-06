class AddDateToTourney < ActiveRecord::Migration
  def change
    add_column :tourneys, :playDate, :date
  end
end
