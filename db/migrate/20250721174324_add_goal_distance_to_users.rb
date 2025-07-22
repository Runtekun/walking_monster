class AddGoalDistanceToUsers < ActiveRecord::Migration[7.2]
  def change
    add_column :users, :goal_distance, :integer
  end
end
