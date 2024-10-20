# frozen_string_literal: true

class Api::V1::UsersController < ApplicationController 
    
    # develop to basic functionaity one for login and second one for signup

    skip_before_action :authorized, only: [:signup]

    def signup
        @user = User.new(user_params)
        if @user.save 
            NotificationJob.perform_later(@user)
            render json: { message: "User created successfully" } , status: :created
        else
            render json: { errors: @user.errors.full_message } , status: :unprocessable_entity 
        end
    end 

    def login
        @user = User.find_by(email: params[:email])
        if @user&.authenticate(params[:password])
          token = encode_token({ user_id: @user.id })
          render json: { user: @user, jwt: token }, status: :ok
        else
          render json: { message: 'Invalid email or password' }, status: :unauthorized
        end
    end 


    private 

    def user_params
        params.require(:user).permit(
            :email,
            :password,
            :username,
            :password_confirmation,
            :phone
        )
    end 
end 
