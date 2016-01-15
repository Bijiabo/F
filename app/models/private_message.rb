class PrivateMessage < ActiveRecord::Base
  belongs_to :toUser, class_name: "User"
  belongs_to :fromUser, class_name: "User"

  mount_uploader :picture, PictureUploader

  validates :toUser, presence: true
  validates :fromUser, presence: true
end
