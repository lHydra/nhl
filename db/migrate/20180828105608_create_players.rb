class CreatePlayers < ActiveRecord::Migration[5.2]
  def change
    create_table :players do |t|
      t.string :name
      t.string :team
      t.string :nation
      t.string :link
      t.integer :capacity
      t.integer :position

      t.timestamps
    end
  end
end
