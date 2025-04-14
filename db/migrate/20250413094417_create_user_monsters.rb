class CreateUserMonsters < ActiveRecord::Migration[7.2]
  def change
    create_table :user_monsters do |t|
      t.references :user, null: false, foreign_key: true
      t.references :monster_species, null: false, foreign_key: true
      t.integer :level, default: 1, null: false
      t.integer :experience, default: 0, null: false

      t.timestamps
    end
  end
end
