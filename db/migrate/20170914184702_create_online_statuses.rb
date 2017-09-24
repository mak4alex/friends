class CreateOnlineStatuses < ActiveRecord::Migration[5.1]
  def change
    create_table :online_statuses do |t|
      t.integer :vk_user_id
      t.integer :platform, :limit => 1
      t.datetime :last_seen, null: false
      t.datetime :created_at, null: false
    end
  end
end
