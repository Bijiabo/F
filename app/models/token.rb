class Token < ActiveRecord::Base
  belongs_to :user

  validates :token, presence: true, length: {maximum: 250, minimum: 8}, uniqueness: {case_sensitive: false}, format: {with: /\A[\w]*\z/}
  validates :name, presence: true

end
