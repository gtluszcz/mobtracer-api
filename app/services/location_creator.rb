
class LocationCreator
  MAX_TRAVEL_SPEED = 9
  class << self
    def create(user, latitude, longitude)
      user = User.find_or_create_by(identifier: user)

      status = calculate_status(user, {lat: latitude.to_f, lon: longitude.to_f})
      Location.create(
          user: user,
          latitude: latitude,
          longitude: longitude,
          status: status
      )
    end

    private

    def calculate_status(user, new_location)
      last_location = last_user_location(user)

      return :unreachable if last_location && !is_reachable?(last_location, new_location)
      :reachable
    end

    def last_user_location(user)
      Location.where(user: user).order(created_at: :desc).first
    end

    def is_reachable?(last_location, new_location)
      distance_in_km = Haversine.distance(
          last_location.latitude,
          last_location.longitude,
          new_location[:lat],
          new_location[:lon]
      ).to_km

      delta_time_in_hours = (Time.now - last_location.created_at) / 3600

      travel_speed = distance_in_km / delta_time_in_hours
      travel_speed <= MAX_TRAVEL_SPEED
    end
  end
end