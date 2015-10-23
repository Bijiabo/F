class Flux < ActiveRecord::Base
  belongs_to :user

  validates :motion, presence: true
  validates :content, length: { maximum:140 }, presence: true
  validates :user_id, presence: true
end
