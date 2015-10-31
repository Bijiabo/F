class Flux < ActiveRecord::Base
  belongs_to :user
  default_scope -> { order(created_at: :desc) }

  validates :user_id, presence: true
  validates :motion, presence: true, length: {maximum: 250}
  validates :content, presence: true, length: {maximum: 140}
end
