class Token < ActiveRecord::Base
  belongs_to :user

  validates :token, presence: true, length: {maximum: 250, minimum: 8}, uniqueness: {case_sensitive: false}
  validates :name, presence: true

  class << self
    def new_token
      SecureRandom.urlsafe_base64
    end

    def authenticate (token)
      tokenItem = Token.find_by(token: token)
      if tokenItem != nil
        tokenItem.user
      end
    end

  end

end
