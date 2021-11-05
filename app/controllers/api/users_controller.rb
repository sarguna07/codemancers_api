module Api
  class UsersController < ApplicationController
    skip_before_action :authorization, only: :create

    def create
      data = User.create!(create_params)
      render json: {
        status: true,
        message: 'Saved Successfully...!',
        data: data.id
      }
    end

    private

    def create_params
      params.permit(:first_name, :last_name, :phone, :email, :status, :password)
    end
  end
end
