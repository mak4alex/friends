class ChangeOnlineStatuses < ActiveRecord::Migration[5.1]
  def change
    add_column :online_statuses, :online, :boolean
    add_column :online_statuses, :online_mobile, :boolean
    remove_column :online_statuses, :created_at, :datetime
  end
end
