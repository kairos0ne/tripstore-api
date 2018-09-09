class Parking < ApplicationRecord
  belongs_to :user

  def time_formats
    attributes['ArrivalTime'].strftime("%H:%M:%S")
    attributes['DepartureTime'].strftime("%H:%M:%S")
  end
end
