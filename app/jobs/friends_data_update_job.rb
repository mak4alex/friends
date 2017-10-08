class FriendsDataUpdateJob < ApplicationJob
  def perform(*args)
    user_ids = User.select(:vk_user_id).map(&:vk_user_id)
    VKUtil.authorized_client.users.get(
      user_ids: user_ids,
      fields:  User::DATA_FIELDS
    ).each do |user_data|
      user_params = ActionController::Parameters.new({ :user => user_data })
      user = User.find_by(:vk_user_id => user_data['uid'])
      user.update_attributes(user_params.require(:user).permit(*User::DATA_FIELDS)) if user
    end
  end
end
