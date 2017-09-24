class CreateTasks < ActiveRecord::Migration[5.1]
  def change
    create_table :tasks do |t|
      t.string :name
      t.string :status
      t.integer :duration
      t.json :attrs

      t.timestamps
    end
  end
end
