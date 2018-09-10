class ParkingSerializer < ActiveModel::Serializer
  attributes :id, :ArrivalDate, :formatted_arrival_time, :DepartDate, :formatted_departure_time, :NumberOfPax, :Title, :Initial, :Surname, :Email, :Waiver, :Remarks, :ABTANumber, :success, :active
  has_one :user
end
