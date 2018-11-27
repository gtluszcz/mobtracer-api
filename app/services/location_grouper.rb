class LocationGrouper
  class << self
    def every_5_seconds
      split_locations_every_5_seconds
    end

    private

    def beginnig_of_5seconds(t)
      t.change(sec: t.sec - t.sec % 5)
    end

    def split_locations_every_5_seconds
      locations = Location.all
      splitted = {}

      locations.each do |location|
        time = beginnig_of_5seconds(location[:created_at]).iso8601
        splitted[time] ||= []
        splitted[time] << LocationSerializer.new(location).as_json
      end
      splitted
    end
  end
end