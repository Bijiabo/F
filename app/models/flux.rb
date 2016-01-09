class Flux < ActiveRecord::Base
  belongs_to :user
  has_many :flux_comments, dependent: :destroy, inverse_of: :flux
  default_scope -> { order(created_at: :desc) }

  validates :user_id, presence: true
  validates :motion, presence: true, length: {maximum: 250}
  validates :content, presence: true, length: {maximum: 140}
  validate :picture_size

  mount_uploader :picture, PictureUploader

  private

  # 验证上传的图片大小
  def picture_size
    maximumSize = 2 # MB
    if picture.size > maximumSize.megabytes
      errors.add(:picture, "should be less than #{maximumSize}MB")
    end
  end

end