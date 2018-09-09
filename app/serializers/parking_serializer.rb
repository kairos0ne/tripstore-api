class ParkingSerializer < ActiveModel::Serializer
  attributes :id, :ArrivalDate, :ArrivalTime, :DepartDate, :DepartTime, :NumberOfPax, :Title, :Initial, :Surname, :Email, :Waiver, :Remarks, :ABTANumber, :success, :active
  has_one :user
end
