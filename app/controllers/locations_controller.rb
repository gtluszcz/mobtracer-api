class LocationsController < ApplicationController
  before_action :check_params, only: [:create]

  def index
    render json: LocationGrouper.every_5_seconds
  end

  def create
    ActiveRecord::Base.transaction do
      user = User.find_or_create_by(identifier: params[:user])
      location = Location.create(
          user: user,
          latitude: params[:latitude],
          longitude: params[:longitude]
      )
      render json: location,status: :created
    end
  end

  private

  def check_params
    params.require([:user,:latitude,:longitude])
  end
end
