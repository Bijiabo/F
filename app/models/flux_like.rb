class FluxLike < ActiveRecord::Base
  belongs_to :user
  belongs_to :flux

  validates :user, presence: true
  validates :flux, presence: true

end
