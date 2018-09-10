class User < ApplicationRecord
  has_secure_password
  has_secure_token

  validates :email,  :presence => true
  validates :email, :uniqueness => true

  has_many :trip, :dependent => :destroy
  has_many :booking, :dependent => :destroy
  has_many :parking, :dependent => :destroy

  def self.valid_login?(email, password)
    user = find_by(email: email)
    if user && user.authenticate(password)
      user
    end
  end

  def allow_token_to_be_used_only_once
    regenerate_token
    touch(:token_created_at)
  end

  def logout
    invalidate_token
  end

  def self.with_unexpired_token(token, period)
    where(token: token).where('token_created_at >= ?', period).first
  end

  def invalidate_token
    update_columns(token: nil)
    touch(:token_created_at)
  end

  private
end