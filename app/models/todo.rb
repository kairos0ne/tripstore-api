class Todo < ApplicationRecord
  validates :title,  :presence => true
  validates :description,  :presence => true
  belongs_to :trip
end
