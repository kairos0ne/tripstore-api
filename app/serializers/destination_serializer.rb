class DestinationSerializer < ActiveModel::Serializer
  attributes :id, :title, :description, :website, :rating, :country, :city, :post_code, :lng, :lat, :formatted_address
end
