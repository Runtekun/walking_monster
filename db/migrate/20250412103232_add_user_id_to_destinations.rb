class AddUserIdToDestinations < ActiveRecord::Migration[7.2]
  def change
    add_reference :destinations, :user, null: false, foreign_key: true
  end
end
