class LocationGrouper
  class << self
    def routes(locations:)
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
  end
end