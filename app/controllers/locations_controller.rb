class LocationsController < ApplicationController
  def index
    locations = Location.includes(:user).where(status: :reachable).all
    render json: LocationGrouper.every_5_seconds(locations: locations)
  end

  def create
    render json: LocationCreator.create(*check_params), status: :created
  end

  def show
    locations = Location.includes(:user).where(status: :reachable, users: {identifier: params[:id]}).all
    if locations.present?
      render json: LocationGrouper.every_5_seconds(locations: locations)
    else
      render status: :bad_request
    end
  end

  private

  def check_params
    params.require([:user,:latitude,:longitude])
  end
end
