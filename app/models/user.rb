class User < ActiveRecord::Base
  has_many :fluxes
end
