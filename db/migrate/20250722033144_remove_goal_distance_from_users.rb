class RemoveGoalDistanceFromUsers < ActiveRecord::Migration[7.2]
  def change
    remove_column :users, :goal_distance, :integer
  end
end
