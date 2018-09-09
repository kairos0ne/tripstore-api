class BookingSerializer < ActiveModel::Serializer
  attributes :id, :ABTANumber, :token, :ArrivalDate, :Nights, :RoomCode, :Adults, :Children, :ParkingDays, :Title, :Initial, :Surname, :Address, :Town, :County, :PostCode, :DayPhone, :Email, :CustomerRef, :Remarks, :Waiver, :DataProtection, :PriceCheckFlag, :PriceCheckPrice, :System, :lang, :user_id, :booking_type, :SecondRoomType, :SecondRoomCode, :SecondRoomAdults, :SecondRoomChildren
  has_one :user
end
