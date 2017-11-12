class GetUsersPostsJob < ApplicationJob
  LIMIT = 100

  def perform(task)
    client  = VKUtil.authorized_client
    users = User.select(:domain, :updated_at)
        .where(:can_see_all_posts => true)
        .order(:updated_at => :desc)
        .limit(LIMIT)

    users.each do |user|
      offset = 0
      wall_posts_count = 0

      loop do
        begin
          task.sleep(3)
          response = client.wall.get(
            :domain => user.domain,
            :extended => VKUtil::API_FALSE,
            :filter => 'all',
            :count => LIMIT,
            :offset => offset
          )
        rescue Exception => exc
          task.log.error(exc.class.name)
          task.log.error(exc.message)
          task.log.error(exc.backtrace[0..10].join("\n"))
          response = []
        end

        wall_posts_count = response.shift.to_i
        enough = (offset + LIMIT) < wall_posts_count

        Post.transaction do
          response.each do |post_hash|
            body = [post_hash['copy_text'], post_hash['text']].compact.join(' ')
            post = Post.find_or_create_by(
                :vk_post_id => post_hash['id'],
                :owner_id   => post_hash['to_id'],
                :from_id    => post_hash['from_id'])
            post.update(
                :body            => body,
                :site_created_at => post_hash['date'],
                :post_kind       => post_hash['post_type'],
                :likes_count     => post_hash.dig('likes', 'count'),
                :reposts_count   => post_hash.dig('reposts', 'count'),
                :comments_count  => post_hash.dig('comments', 'count'),
                :views_count     => post_hash.dig('views', 'count'),
            )
          end
        end

        break task.stopping? || response.empty? || enough
        offset += LIMIT
      end

      task.log.info("Post updating for: #{name} done, found: #{wall_posts_count}")
      user.touch
      break if task.stopping?
    end
    task.log.info('Successfully done')
  end
end
