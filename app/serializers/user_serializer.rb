class UserSerializer < ActiveModel::Serializer
    attributes :id, :name, :email, :admin, :member
    has_many :trip
  end
  