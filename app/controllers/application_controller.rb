class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  def authenticate
    authenticate_or_request_with_http_basic do |name, password|
      name == ENV['AUTH_NAME'] && password == ENV['AUTH_PASSWORD']
    end
  end
end
