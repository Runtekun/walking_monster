class AddGoalStepsToUsers < ActiveRecord::Migration[7.2]
  def change
    add_column :users, :goal_steps, :integer
  end
end
