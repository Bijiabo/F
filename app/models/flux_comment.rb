class FluxComment < ActiveRecord::Base
  belongs_to :user
  belongs_to :flux

  has_many :childComment, class_name: "FluxComment"#, foreign_key: "childComment_id"
  belongs_to :parentComment, class_name: "FluxComment"#, foreign_key: "parentComment_id"

  has_many :trend
end
