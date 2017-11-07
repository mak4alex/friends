# Preview all emails at http://localhost:3000/rails/mailers/support_mailer
class SupportMailerPreview < ActionMailer::Preview
  def sample_mail_preview
    SupportMailer.send_public_id
  end
end
