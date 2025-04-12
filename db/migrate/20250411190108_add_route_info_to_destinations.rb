class AddRouteInfoToDestinations < ActiveRecord::Migration[7.2]
  def change
    add_column :destinations, :start, :string
    add_column :destinations, :end, :string
    add_column :destinations, :distance, :string
    add_column :destinations, :duration, :string
    add_column :destinations, :steps, :integer
  end
end
