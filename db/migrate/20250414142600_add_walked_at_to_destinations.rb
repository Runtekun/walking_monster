class AddWalkedAtToDestinations < ActiveRecord::Migration[7.2]
  def change
    add_column :destinations, :walked_at, :datetime
  end
end
