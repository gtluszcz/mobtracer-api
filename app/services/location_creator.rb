
class LocationCreator
  MAX_TRAVEL_SPEED = 9
  class << self
    def create(user, latitude, longitude)
      Location.transaction do
        user = User.find_or_create_by(identifier: user)
        new_location = create_basic_location(user, latitude, longitude)
        set_proper_status(user,new_location)
        return new_location
      end
    end

    private

    def create_basic_location(user, latitude, longitude)
      location = Location.create(
          user: user,
          latitude: latitude,
          longitude: longitude
      )
      return location
    end

    def set_proper_status(user, new_location)
      last_location = last_user_location(user)
      if last_location.present? && !is_reachable?(last_location, new_location)
        new_location.update!(status: :unreachable)
      end
    end

    def last_user_location(user)
      Location.where(user: user).order(created_at: :desc).second
    end

    def is_reachable?(last_location, new_location)
      distance_in_km = Haversine.distance(
          last_location.latitude,
          last_location.longitude,
          new_location.latitude,
          new_location.longitude
      ).to_km

      delta_time_in_hours = (new_location.created_at - last_location.created_at) / 3600

      travel_speed = distance_in_km / delta_time_in_hours
      travel_speed <= MAX_TRAVEL_SPEED
    end
  end
end