class View < ApplicationRecord
  belongs_to :post
  belongs_to :user
  validates :post, uniqueness: { scope: :user}

  def is_young
    post.created_at > 1.day.ago
  end

  def is_own_post
    user == post.user
  end
  

  def locked
    if is_young || is_own_post
      return false
    else
      super
    end
  end 

  def self.create(post, user)
    view = View.find_by(post: post, user: user)
    unless view
      view = View.new(post: post, user: user)
      view.save
    end
    view.render
  end

  def self.batch_create(user, posts_collection)
    posts_collection.map do |post|
      create(post, user)
    end
    
  end

  def unlocked_view
    view_hash = self.as_json
    view_hash[:post] = post.with_user_and_comments
    view_hash
  end

  def metrics 
    metrics = post.metrics
    metrics[:user] = post.user.profile
    metrics[:view_id] = id
    metrics
  end

  def locked_view
    view_hash = self.as_json
    view_hash[:metrics] = metrics
    view_hash
  end

  def render
    locked ? locked_view : unlocked_view
  end
  
  
  
  
end
