class LocationCreator
  class << self
    def create(user, latitude, longitude)
      Location.transaction do
        user = User.find_or_create_by(identifier: user)
        location = Location.create(
            user: user,
            latitude: latitude,
            longitude: longitude
        )
        return location
      end
    end
  end
end