class ParkingSerializer < ActiveModel::Serializer
  attributes :id, :ArrivalDate, :ArrivalTime, :DepartDate, :DepartTime, :NumberOfPax, :Title, :Initial, :Surname, :Email, :Waiver, :Remarks, :ABTANumber
  has_one :user
end
