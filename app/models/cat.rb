class Cat < ActiveRecord::Base
  belongs_to :user

  validates :name, presence: true, length: {maximum: 50}
  validates :age, presence: true, inclusion: 0..25, numericality: { only_integer: true }
  validates :breed, presence: true, length: {maximum: 50}

end
