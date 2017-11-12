class CreatePosts < ActiveRecord::Migration[5.1]
  def change
    create_table :posts do |t|
      t.integer :vk_post_id
      t.integer :owner_id
      t.integer :from_id
      t.datetime :site_created_at
      t.text :body
      t.string :post_kind, limit: 16
      t.integer :likes_count
      t.integer :reposts_count
      t.integer :comments_count
      t.integer :views_count

      t.timestamps
    end

    add_index :posts, [:vk_post_id, :owner_id, :from_id], unique: true
  end
end
