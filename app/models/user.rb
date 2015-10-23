class User < ActiveRecord::Base
  has_many :fluxes

  before_save {self.email = email.downcase}

  validates :name, presence: true, length: {maximum: 50}
  VALID_EMAIL_REGEX = /\w[-\w.+]*@([A-Za-z0-9][-A-Za-z0-9]+\.)+[A-Za-z]{2,14}/
  validates :email, presence: true, length: {maximum: 255}, format: {with: VALID_EMAIL_REGEX}, uniqueness: {case_sensitive: false}

  has_secure_password
  validates :password, presence: true, length: {minimum: 6}
end
