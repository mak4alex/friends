class EmailListenerJob < ApplicationJob
  def perform(*args)
    Mail.all.each do |email|
      subject = email.subject
      from_email = email.from.first
      puts "Got new email #{subject} from #{from_email}"
      if email.subject.gsub(/\W/, '') =~ /givemeyouripbaby/i
        SupportMailer.send_public_id(from_email).deliver_later
      end      
    end
  end
end
