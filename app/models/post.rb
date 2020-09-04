class Post < ApplicationRecord
  belongs_to :user
  has_many :comments
  has_many :views

  def with_user_and_comments
    p = self.as_json
    p[:user] = user
    p[:comments] = comments.with_users
    p
  end

  def self.with_users_and_comments
    all.map { |p| p.with_user_and_comments}
  end

  def metrics
    {
      views: self.views.length,
      comments: self.comments.length
    }
  end

  def is_young
    created_at > 1.day.ago
  end
  
  


  
end
