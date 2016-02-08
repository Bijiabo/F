class PrivateMessage < ActiveRecord::Base
  belongs_to :to_user, class_name: "User"
  belongs_to :from_user, class_name: "User"

  mount_uploader :picture, PictureUploader

  validates :to_user, presence: true
  validates :from_user, presence: true
end
