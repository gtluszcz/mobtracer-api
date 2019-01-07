class LocationsController < ApplicationController
  def index
    locations = Location
                    .joins(:user)
                    .where(status: :reachable)
                    .where('locations.created_at> ?',Time.now-24.hours)
                    .order(created_at: :desc)
                    .group_by(&:user_id)
                    .map{|k,v| v.first}
    render json: locations
  end

  def create
    render json: LocationCreator.create(*check_params), status: :created
  end

  def show
    locations = Location.includes(:user).where(users: {identifier: params[:id]}).all
    if locations.present?
      routes =  LocationGrouper.routes(locations: locations)
      render json: routes.map{|el| ActiveModel::Serializer::CollectionSerializer.new(el)}
    else
      render status: :bad_request
    end
  end

  private

  def check_params
    params.require([:user,:latitude,:longitude])
  end
end
