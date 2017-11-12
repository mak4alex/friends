class CreateLinks < ActiveRecord::Migration[5.1]
  def change
    create_table :links do |t|
      t.integer :vk_user_id
      t.integer :vk_object_id
      t.string :linkable_type, limit: 16

      t.timestamps
    end

    add_index :links, [:vk_user_id, :vk_object_id, :linkable_type], unique: true
  end
end
