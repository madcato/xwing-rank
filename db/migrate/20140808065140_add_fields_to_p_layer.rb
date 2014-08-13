class AddFieldsToPLayer < ActiveRecord::Migration
  def change
    add_column :players, :email, :string
    add_column :players, :city, :string
  end
end
