class ChangeEncoding < ActiveRecord::Migration[5.1]
  def up
    execute(
      "ALTER TABLE `users` \
       CONVERT TO CHARACTER SET utf8mb4 COLLATE utf8mb4_bin, \
       MODIFY `status` VARCHAR(250) \
       CHARACTER SET utf8mb4 COLLATE utf8mb4_bin"
    )
  end

  def down
    raise ActiveRecord::IrreversibleMigration
  end
end
