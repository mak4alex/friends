class RenameTypeTaskColumn < ActiveRecord::Migration[5.1]
  def change
    rename_column :tasks, :type, :mode_type
  end
end
