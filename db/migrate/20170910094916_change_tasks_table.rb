class ChangeTasksTable < ActiveRecord::Migration[5.1]
  def change
    add_column :tasks, :delay, :integer
    add_column :tasks, :type, :string
    add_column :tasks, :cycle_count, :integer
    remove_column :tasks, :attrs, :json
  end
end
