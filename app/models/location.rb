class Location < ApplicationRecord
  belongs_to :user

  enum status: [:reachable, :unreachable]
end
