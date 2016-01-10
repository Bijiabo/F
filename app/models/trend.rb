class Trend < ActiveRecord::Base
  belongs_to :to_user, class_name:  "User", foreign_key: "to_user_id"
  belongs_to :from_user, class_name:  "User", foreign_key: "from_user_id"
  belongs_to :to_cat, class_name:  "Cat", foreign_key: "to_cat_id"
  belongs_to :from_cat, class_name:  "Cat", foreign_key: "from_cat_id"
  belongs_to :flux, class_name:  "Flux", foreign_key: "flux_id"
end
