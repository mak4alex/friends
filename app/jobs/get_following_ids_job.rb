class GetFollowingIdsJob < ApplicationJob
  def perform(*args)
    client = VKUtil.authorized_client
    friends_ids = client.friends.get.to_a
    requested_ids = client.friends.getRequests(out: 1).to_a
    existed_ids = User.select(:vk_user_id).map(&:vk_user_id)
    missing_ids = (friends_ids + requested_ids) - existed_ids
    User.create(missing_ids.map { |id| { vk_user_id: id } })   
  end
end
