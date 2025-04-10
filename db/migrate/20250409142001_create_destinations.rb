class CreateDestinations < ActiveRecord::Migration[7.2]
  def change
    create_table :destinations do |t|
      t.string :address
      t.float :latitude
      t.float :longitude

      t.timestamps
    end
  end
end
