class Comment < ActiveRecord::Base
  attr_accessible :comment_id, :commented, :contents, :user_id , :source_id
  
  def Comment.get_comment(num)
    Comment.order("id DESC").limit(num)
  end
end
