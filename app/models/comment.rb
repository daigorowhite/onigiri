class Comment < ActiveRecord::Base
  attr_accessible :comment_id, :commented, :contents, :user_id
end
