class TripSerializer < ActiveModel::Serializer
  attributes :id, :start_date, :end_date, :departure_airport_code, :arrival_airport_code, :formatted_arrival_time, :formatted_departure_time
  has_many :destination
  has_many :todo
end
