class LocationSerializer < ActiveModel::Serializer
  attributes :id,:user,:latitude,:longitude,:status

  def user
    object.user.identifier
  end

end
