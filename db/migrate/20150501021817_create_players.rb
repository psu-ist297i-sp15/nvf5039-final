class CreatePlayers < ActiveRecord::Migration
  def change
    create_table :players do |t|
      t.string :riotID
      t.string :name
      t.integer :k
      t.integer :d
      t.integer :a
      t.integer :cs
      t.integer :triple
      t.integer :quadra
      t.integer :penta
      t.integer :towers
      t.integer :inhibs
      t.integer :dragon
      t.integer :baron

      t.timestamps null: false
    end
  end
end
