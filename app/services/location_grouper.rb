class LocationGrouper
  class << self
    RADIUS = 20
    def routes(locations:)
      routes = find_routes(locations)
      remove_stoppage_points(routes)
    end


    def find_routes(locations)
      routes=[]
      counter = 0
      locations.each do |location|
        if location.reachable?
          routes[counter] ||= []
          routes[counter] << location
        else
          counter+=1 if routes[counter].present?
        end
      end
      routes
    end

    def remove_stoppage_points(locations)
      locations.select do |path|
        srodek = {lat: 0, lon: 0}
        path.each do |loc|
          srodek[:lat] += loc.latitude
          srodek[:lon] += loc.longitude
        end

        srodek[:lat] /= path.count
        srodek[:lon] /= path.count

        path.any? do |loc|
          distance_in_m = Haversine.distance(
              loc.latitude,
              loc.longitude,
              srodek[:lat],
              srodek[:lon]
          ).to_m
          distance_in_m > RADIUS
        end
      end
    end

  end
end