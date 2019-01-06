class Location < ApplicationRecord
  belongs_to :user

  enum status: %i[valid invalid]
end
