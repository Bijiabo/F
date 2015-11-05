class Token < ActiveRecord::Base
  belongs_to :user

  validates :token, presence: true, length: {maximum: 250, minimum: 8}, uniqueness: {case_sensitive: false}
  # device' name, default provide by applicaiton client, it could change by user.
  validates :name, presence: true
  # device's id string, provide by application client.
  validates :deviceID, presence: true, length: {maximum: 250, minimum: 4}, uniqueness: {case_sensitive: false}

  class << self
    def new_token
      SecureRandom.urlsafe_base64
    end

    def authenticate (token)
      Token.find_by(token: token)
    end

  end

end
