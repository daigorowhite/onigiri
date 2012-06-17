class User < ActiveRecord::Base
  attr_accessible :user_id, :user_name, :user_password
end
