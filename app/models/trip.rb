class Trip < ApplicationRecord
  validates :start_date,  :presence => true
  validates :end_date,  :presence => true
  belongs_to :user
  has_many :todo, :dependent => :destroy
  has_many :destination, :dependent => :destroy
end
