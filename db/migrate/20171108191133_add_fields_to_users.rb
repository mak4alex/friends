class AddFieldsToUsers < ActiveRecord::Migration[5.1]
  def change
    add_column :users, :about, :text
    add_column :users, :birthday, :string
    add_column :users, :can_see_all_posts, :boolean
    add_column :users, :can_comment_on_wall, :boolean
    add_column :users, :deactivated, :string

    add_index(:users, :vk_user_id, :unique => true)
  end
end
