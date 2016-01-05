class AddIsAdminToPlayers < ActiveRecord::Migration
  def change
    add_column :players, :is_admin, :boolean, :default => false
  end
end
