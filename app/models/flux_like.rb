class FluxLike < ActiveRecord::Base
  belongs_to :user
  belongs_to :flux
  belongs_to :flux_comment

  validates :user, presence: true
  validates :flux, presence: true

end
