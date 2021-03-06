class OnlineStatusUpdateJob < ApplicationJob

  before_enqueue do |job|
    @@statuses = Set.new
    @@user_ids = User.select(:vk_user_id).where(id:[85..133]).map(&:vk_user_id)
  end

  def perform(*args)
    statuses = VK::Client.new.users.get(
      user_ids: @@user_ids,
      fields:   User::ONLINE_FIELDS
    ).to_set

    new_statuses = statuses - @@statuses
    method = @@statuses.empty? ? :find_or_create_by : :create
    OnlineStatus.transaction do
      new_statuses.each do |user_data|
        next if user_data["deactivated"] # "banned"
        OnlineStatus.send(method, {
          :vk_user_id => user_data['uid'],
          :last_seen  => Time.at(user_data['last_seen']['time']),
          :platform   => user_data['last_seen']['platform'],
          :online     => user_data['online'] == VKUtil::API_TRUE,
          :online_mobile => user_data.key?('online_mobile')
        })
      end
    end
    @@statuses = statuses
  end
end
