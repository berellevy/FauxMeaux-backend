class View < ApplicationRecord
  belongs_to :post
  belongs_to :user
  validates :post, uniqueness: { scope: :user}


  def self.create(post, user)
    view = View.find_by(post: post, user: user)
    unless view
      view = View.new(post: post, user: user)
      view.save
    end
    view.with_dependents
  end

  def self.batch_create(user, posts_collection)
    posts_collection.map do |post|
      create(post, user)
    end
    
  end

  def with_dependents
    view_hash = self.as_json
    view_hash[:post] = post.with_user_and_comments
    view_hash
  end
  
  
  
end
