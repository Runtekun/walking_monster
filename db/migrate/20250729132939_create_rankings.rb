class CreateRankings < ActiveRecord::Migration[7.2]
  def change
    create_table :rankings do |t|
      t.references :user, null: false, foreign_key: true
      t.integer :rank
      t.integer :score
      t.string :category
      t.datetime :recorded_at

      t.timestamps
    end

    add_index :rankings, [ :category, :recorded_at ]
  end
end
