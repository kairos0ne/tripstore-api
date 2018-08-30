class TodoSerializer < ActiveModel::Serializer
  attributes :id, :title, :description
  has_one :trip
end
