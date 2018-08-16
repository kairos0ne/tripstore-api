class TripSerializer < ActiveModel::Serializer
  attributes :id, :start_date, :end_date, :destination, :departure_airport_code, :arrival_airport_code, :departure_time, :arrival_time

end
