class CreateUsers < ActiveRecord::Migration[5.1]
  def change
    create_table :users do |t|
      t.integer :vk_user_id
      t.string :first_name
      t.string :last_name
      t.integer :sex, :limit => 1
      t.string :domain
      t.string :screen_name
      t.string :photo_50
      t.string :photo_100
      t.string :photo_400_orig
      t.string :status
      t.boolean :hidden

      t.timestamps
    end
  end
end
