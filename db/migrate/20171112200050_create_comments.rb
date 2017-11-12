class CreateComments < ActiveRecord::Migration[5.1]
  def change
    create_table :comments do |t|
      t.integer :vk_comment_id
      t.integer :vk_post_id
      t.integer :vk_user_id
      t.text :body
      t.integer :likes_count
      t.integer :site_created_at

      t.timestamps
    end

    add_index :comments, [:vk_comment_id, :vk_user_id, :vk_post_id], unique: true
  end
end
