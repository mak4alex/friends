class OnlineStatusUpdateJob < ApplicationJob
  def perform(*args)
    VK::Client.new.friends.get(
      user_id: ENV['VK_SPYER_ID'],
      fields:  User::ONLINE_FIELDS
    ).each do |user_data|
      next if user_data["deactivated"] # "banned"

      OnlineStatus.find_or_create_by({
        :vk_user_id => user_data['user_id'],
        :last_seen  => Time.at(user_data['last_seen']['time']),
        :platform   => user_data['last_seen']['platform'],
        :online     => user_data['online'] == User::ONLINE,
        :online_mobile => user_data.key?('online_mobile')
      })
    end
  end
end
