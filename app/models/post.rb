class Post < ApplicationRecord
  belongs_to :user
  has_many :comments

  def with_user_and_comments
    p = self.as_json
    p[:user] = user
    p[:comments] = comments.map { |c| c.with_user}
    p
  end

  def self.with_users_and_comments
    all.map { |p| p.with_user_and_comments}
  end
  


  
end
