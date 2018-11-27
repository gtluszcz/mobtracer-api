class LocationsController < ApplicationController
  def index
    render json: LocationGrouper.every_5_seconds
  end

  def create
    render json: LocationCreator.create(*check_params)
  end

  private

  def check_params
    params.require([:user,:latitude,:longitude])
  end
end
