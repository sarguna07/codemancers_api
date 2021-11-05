class ApplicationController < ActionController::API
  include ExceptionHandler

  before_action :authorization

  skip_before_action :authorization, only: :catch_all

  def catch_all
    return_404
  end

  private

  def authorization
    current_user
  rescue StandardError => _e
    raise Unauthorized
  end

  def current_user
    User.active.find_by!(auth_token: auth_header)
  end

  def auth_header
    request.headers['Authorization']
  end
end
