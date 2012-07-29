class User < ActiveRecord::Base
  attr_accessible :id, :user_id, :user_name, :user_password
end
