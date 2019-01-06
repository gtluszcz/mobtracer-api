class LocationsController < ApplicationController
  def index
    locations = Location.includes(:user).where(status: :valid).all
    render json: LocationGrouper.every_5_seconds(locations: locations)
  end

  def create
    render json: LocationCreator.create(*check_params), status: :created
  end

  def show
    user = User.includes(:locations).where(status: :valid).find_by(identifier: params[:id])
    if user.present?
      render json: LocationGrouper.every_5_seconds(locations: user.locations)
    else
      render status: :bad_request
    end
  end

  private

  def check_params
    params.require([:user,:latitude,:longitude])
  end
end
