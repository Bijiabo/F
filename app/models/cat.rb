class Cat < ActiveRecord::Base

  acts_as_mappable :default_units => :miles,
                   :default_formula => :sphere,
                   :distance_field_name => :distance,
                   :lat_column_name => :latitude,
                   :lng_column_name => :longitude

  belongs_to :user

  # trends
  has_many :to_trends, class_name:  "Trend", foreign_key: "to_cat_id", dependent: :destroy
  has_many :from_trends, class_name:  "Trend", foreign_key: "from_cat_id", dependent: :destroy

  validates :name, presence: true, length: {maximum: 50}
  validates :age, presence: true, inclusion: 0..25, numericality: { only_integer: true }
  validates :breed, presence: true, length: {maximum: 50}

  mount_uploader :avatar, PictureUploader

end
