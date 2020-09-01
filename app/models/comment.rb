class Comment < ApplicationRecord
  belongs_to :user
  belongs_to :post

  def with_user
    comment = self
    comment_hash = comment.as_json
    comment_hash[:user] = comment.user.profile
    comment_hash
  end

  def self.with_users
    self.order(updated_at: :desc).map { |c| c.with_user }
  end
  
  
end
