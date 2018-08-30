class Todo < ApplicationRecord
  validates :title,  :presence => true
  validates :description,  :presence => true
  belongs_to :trip
  # has_one :user, :through => :trip
end
