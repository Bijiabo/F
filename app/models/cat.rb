class Cat < ActiveRecord::Base

  acts_as_mappable :default_units => :miles,
                   :default_formula => :sphere,
                   :distance_field_name => :distance,
                   :lat_column_name => :latitude,
                   :lng_column_name => :longitude

  belongs_to :user

  # trends
  has_many :trends, dependent: :destroy, inverse_of: :cat

  validates :name, presence: true, length: {maximum: 50}
  validates :age, presence: true, inclusion: 0..25, numericality: { only_integer: true }
  validates :breed, presence: true, length: {maximum: 50}

end
