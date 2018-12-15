class LocationsController < ApplicationController
  def index
    locations = Location.all.includes(:user)
    render json: LocationGrouper.every_5_seconds(locations: locations)
  end

  def create
    render json: LocationCreator.create(*check_params), status: :created
  end

  def show
    locations = Location.includes(:user).where(users: {identifier: params[:id]})
    render json: LocationGrouper.every_5_seconds(locations: locations)
  end

  private

  def check_params
    params.require([:user,:latitude,:longitude])
  end
end
