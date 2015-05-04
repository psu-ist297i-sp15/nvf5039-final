class RemoveTripleAndQuadraAndPentaAndTowersAndInhibsAndDragonAndBaronFromPlayers < ActiveRecord::Migration
  def change
    remove_column :players, :triple, :integer
    remove_column :players, :quadra, :integer
    remove_column :players, :penta, :integer
    remove_column :players, :towers, :integer
    remove_column :players, :inhibs, :integer
    remove_column :players, :dragon, :integer
    remove_column :players, :baron, :integer
  end
end
