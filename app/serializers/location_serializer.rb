class LocationSerializer < ActiveModel::Serializer
  attributes :id,:user,:latitude,:longitude,:status,:created_at

  def user
    object.user.identifier
  end

end
