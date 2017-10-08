class VKUtil
  def self.authorized_client(scope: [:friends, :groups])
    agent = Mechanize.new
    agent.get VkontakteApi.authorization_url(scope: scope, type: :client)

    agent.page.form_with(action: /login.vk.com/) do |form|
     form.email = ENV['VK_PHOHE']
     form.pass  = ENV['VK_PASSWORD']
    end.submit

    agent.page.form.submit if agent.page.uri.fragment.nil?

    token = agent.page.uri.fragment.split('&').each_with_object(Hash.new) do |pair, hash|
      key, value = pair.split('=')
      hash[key] = value
    end.fetch('access_token')

    VkontakteApi::Client.new(token)
  end
end
