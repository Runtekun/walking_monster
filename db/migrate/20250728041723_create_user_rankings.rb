class CreateUserRankings < ActiveRecord::Migration[7.2]
  def change
    create_table :user_rankings do |t|
      t.references :user, null: false, foreign_key: true
      t.integer :score, null: false
      t.string :ranking_category, null: false
      t.string :ranking_period, null: false
      t.date :period_start
      t.date :period_end
      t.integer :rank, null: false

      t.timestamps
    end

    add_index :user_rankings, [:ranking_category, :ranking_period, :period_start], name: "index_rankings_on_cat_and_period"
  end
end