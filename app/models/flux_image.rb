class FluxImage < ActiveRecord::Base
  belongs_to :flux

  mount_uploader :picture, PictureUploader
end
