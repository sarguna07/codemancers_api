class AuthenticationController < ApplicationController
  skip_before_action :authorization, only: :login

  def login
    user = User.active.where('lower(email) = ?', username).
          find_by(password: hexdigest(params[:password].to_s))

    reset_session
    if user.blank?
      render json: {
        status: false,
        message: 'Invalid Credentials'
      }, status: :unauthorized
      return
    end

    unless user.active?
      render json: {
        status: false,
        message: 'Account is inactive'
      }, status: :unauthorized
      return
    end

    render json: {
      status: true,
      message: 'Login Successful',
      data: user.as_json(except: %i[password created_at updated_at])
    }
  end

  def logout
    current_user.update_attributes!(auth_token: nil)
    reset_session
    render json: {
      status: true,
      message: 'Logout Successfull'
    }
  end

  private

  def username
    params[:user_name].to_s.downcase
  end
end
