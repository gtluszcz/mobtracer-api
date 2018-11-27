class LocationSerializer < ActiveModel::Serializer
  attributes :id,:user,:latitude,:longitude

  def user
    object.user.identifier
  end

end
