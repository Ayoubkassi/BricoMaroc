#frozen_string_literal: true 

class Api::V1::ProfilesController < ApplicationController

    before_action :authorized

    def index 
        @profiles = Profile.all 
        render json: @profiles
    end
    
    def create 
        @profile = Profile.new(profile_params)
        profile.user = current_user

        if @profile.save 
            render json: @profile , status: :created 
        else 
            render json: { errors: @profile.errors.full_message }, status: :unprocessable_entity
        end 
    end
    
    private 

    def profile_params 
        params.require(:profile).permit(:name, :profession, :bio, :location)
    end 
end 