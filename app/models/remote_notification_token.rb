class RemoteNotificationToken < ActiveRecord::Base
  belongs_to :user

  validates :token, presence: true, length: {maximum: 255}, uniqueness: {case_sensitive: false}
end
