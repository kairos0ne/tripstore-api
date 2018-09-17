class Credential < ApplicationRecord
    validates :account_number,  :presence => true
    validates :name,  :presence => true
    validates :name, :uniqueness => true
    validates :password,  :presence => true
    validates :key,  :presence => true
    validates :initials,  :presence => true
end
