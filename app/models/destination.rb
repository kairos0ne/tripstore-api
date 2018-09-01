class Destination < ApplicationRecord
  validates :title,  :presence => true
  belongs_to :trip
end
