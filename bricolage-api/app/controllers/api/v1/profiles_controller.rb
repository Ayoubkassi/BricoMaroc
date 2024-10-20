# frozen_string_literal: true 

class Api::V1::ProfilesController < ApplicationController
    before_action :authorized
    before_action :set_profile, only: [:update]
  
    # GET /api/v1/profiles
    def index 
      @profiles = Profile.all 
      render json: @profiles
    end
    
    # POST /api/v1/profiles
    def create 
      @profile = Profile.new(profile_params)
      @profile.user = current_user # Associate the profile with the current user
  
      if @profile.save 
        render json: @profile, status: :created 
      else 
        render json: { errors: @profile.errors.full_messages }, status: :unprocessable_entity
      end 
    end
  
    # GET /api/v1/profiles/search
    def search
      # Check for presence of latitude and longitude
      unless params[:latitude].present? && params[:longitude].present?
        render json: { error: 'Latitude and Longitude are required' }, status: :bad_request
        return
      end
  
      # Get latitude and longitude from params
      user_latitude = params[:latitude].to_f
      user_longitude = params[:longitude].to_f
      
      # Set default value for distance if not provided
      distance = params[:n].to_f.nonzero? || 5.0 # default to 5 if n is nil or empty
  
      # Perform the search using geocoded coordinates and distance
      @profiles = Profile.near([user_latitude, user_longitude], distance)
  
      render json: @profiles
    end 
  
    # PATCH/PUT /api/v1/profiles/:id
    def update
      if @profile.update(profile_params)
        render json: @profile, status: :ok 
      else 
        render json: { errors: @profile.errors.full_messages }, status: :unprocessable_entity
      end 
    end 
    
    private 
  
    # Set the profile based on the ID in the params
    def set_profile
      @profile = Profile.find(params[:id])
    rescue ActiveRecord::RecordNotFound
      render json: { error: 'Profile not found' }, status: :not_found
    end
  
    # Strong parameters for profile
    def profile_params 
      params.require(:profile).permit(:name, :profession, :bio, :location)
    end 
  end  
  