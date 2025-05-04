class AddIndexUidAndProviderToUsers < ActiveRecord::Migration[7.2]
  def change
    add_index :users, [ :uid, :provider ], unique: true
  end
end
