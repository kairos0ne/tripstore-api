class Trip < ApplicationRecord
  validates :start_date,  :presence => true
  validates :end_date,  :presence => true
  belongs_to :user
  has_many :todo, :dependent => :destroy
  has_many :destination, :dependent => :destroy

  def formatted_arrival_time
    self.arrival_time.strftime("%H:%M")
  end

  def formatted_departure_time
    self.departure_time.strftime("%H:%M")
  end
end
