class SupportMailer < ApplicationMailer
  def send_public_id(to_email)
    @ip = %x{curl https://api.ipify.org}
    mail(to: to_email, subject: 'DS Project Public IP')
  end
end
