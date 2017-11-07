Mail.defaults do
  retriever_method( :pop3, 
    :address    => 'pop.gmail.com',
    :port       => 995,
    :user_name  => ENV['GMAIL_USERNAME'],
    :password   => ENV['GMAIL_PASSWORD'],
    :enable_ssl => true
  )
end
