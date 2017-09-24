class FriendsDataUpdateJob < ApplicationJob
  def perform(*args)
    VK::Client.new.friends.get(
      user_id: ENV['VK_SPYER_ID'],
      fields:  User::DATA_FIELDS
    ).each do |user_data|
      user_params = ActionController::Parameters.new({ :user => user_data })
      User.find_or_create_by(:vk_user_id => user_data['user_id']) do |user|
        user.update_attributes(user_params.require(:user).permit(*User::DATA_FIELDS))
      end
    end
  end
end
