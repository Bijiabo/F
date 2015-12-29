class Cat < ActiveRecord::Base

  acts_as_mappable :default_units => :miles,
                   :default_formula => :sphere,
                   :distance_field_name => :distance,
                   :lat_column_name => :lat,
                   :lng_column_name => :lng

  belongs_to :user

  validates :name, presence: true, length: {maximum: 50}
  validates :age, presence: true, inclusion: 0..25, numericality: { only_integer: true }
  validates :breed, presence: true, length: {maximum: 50}

end
