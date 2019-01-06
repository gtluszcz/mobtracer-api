class LocationCreator
  MAX_ALLOWED_DISTANCE = 1000
  class << self
    def create(user, latitude, longitude)
      Location.transaction do
        user = User.find_or_create_by(identifier: user)
        new_location = create_basic_location(user, latitude, longitude)

        last_location = last_user_location(user)
        if last_location.present? && is_reachable?(last_location, new_location)
          new_location.update!(status: :unreachable)
        end
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

    def is_reachable?(last_location, new_location)
      return true
    end

    def last_user_location(user)
      Location.where(user: user).order(created_at: :desc).first
    end
  end
end