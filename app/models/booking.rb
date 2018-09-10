class Booking < ApplicationRecord
  validates :ABTANumber,  :presence => true
  validates :token,  :presence => true
  validates :ArrivalDate,  :presence => true
  validates :Nights,  :presence => true
  validates :RoomCode, :presence => true
  validates :Adults, :presence => true
  validates :Children, :presence => true
  validates :ParkingDays, :presence => true
  validates :Title, :presence => true
  validates :Initial, :presence => true
  validates :Surname, :presence => true
  validates :Address, :presence => true
  validates :Town, :presence => true
  validates :County, :presence => true
  validates :PostCode, :presence => true
  validates :Email, :presence => true
  # validates :Waiver, :presence => true
  validates :PriceCheckFlag, :presence => true
  validates :PriceCheckPrice, :presence => true
  validates :System, :presence => true
  validates :lang, :presence => true
  
  belongs_to :user
end
