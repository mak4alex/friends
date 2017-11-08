class SearchUsersJob < ApplicationJob
  LIMIT = 1000

  def perform(*args)
    task = args.first
    task.set_logger
    total_count = 0
    names = 
    client = VKUtil.authorized_client

    loop do
      name = names.sample      
      sleep(5)
      response = client.users.search(
        :q       => name,
        :online  => User::API_TRUE,
        :city    => User::CITIES['MINSK'], 
        :country => User::COUNTRIES['BELARUS'],
        :fields  => User::DATA_FIELDS, 
        :count   => LIMIT, 
        :offset  => 0
      )

      res_users_size = response.shift
      names.delete(name) if res_users_size < LIMIT

      User.transaction do
        response.each do |user_hash|
          user = User.find_or_create_by(vk_user_id: user_hash['uid'])
          user.update(
            :first_name  => user_hash['first_name'],
            :last_name   => user_hash['last_name'],
            :sex         => user_hash['sex'],
            :domain      => user_hash['domain'],
            :screen_name => user_hash['screen_name'],
            :photo_50    => user_hash['photo_50'],
            :photo_100   => user_hash['photo_100'],
            :photo_400_orig => user_hash['photo_400_orig'],
            :status    => user_hash['status'],
            :hidden    => user_hash['hidden'],
            :about     => user_hash['about'],
            :birthday  => user_hash['bdate'],
            :can_see_all_posts   => user_hash['can_see_all_posts'] == User::API_TRUE,
            :can_comment_on_wall => user_hash['wall_comments']     == User::API_TRUE,
            :deactivated         => user_hash['deactivated'],
          )
        end
      end

      total_count += res_users_size
      task.logger.info("name '#{name}', res: #{res_users_size}, total: #{total_count}, names left #{names.size}")
      break if task.stopping?
    end 
  end
end
