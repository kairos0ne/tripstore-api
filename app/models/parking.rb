class Parking < ApplicationRecord
  
  validates :ArrivalDate,  :presence => true
  validates :ArrivalTime,  :presence => true
  validates :DepartTime,  :presence => true
  validates :DepartDate,  :presence => true
  validates :ABTANumber, :presence => true
  validates :NumberOfPax, :presence => true
  validates :Email, :presence => true
  
  belongs_to :user

  def formatted_arrival_time
    self.ArrivalTime.strftime("%H:%M:%S")
  end

  def formatted_departure_time
    self.DepartTime.strftime("%H:%M:%S")
  end
end
