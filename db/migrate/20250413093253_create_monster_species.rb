class CreateMonsterSpecies < ActiveRecord::Migration[7.2]
  def change
    create_table :monster_species do |t|
      t.string :name_stage_1
      t.string :name_stage_2
      t.string :name_stage_3
      t.text :description
      t.string :image_1
      t.string :image_2
      t.string :image_3
      t.integer :evolution_level_1
      t.integer :evolution_level_2

      t.timestamps
    end
  end
end
