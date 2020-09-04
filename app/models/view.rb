class View < ApplicationRecord
  belongs_to :post
  belongs_to :user
  belongs_to :ad, optional: true
  validates :post, uniqueness: { scope: :user}

  def is_young
    post.is_young
  end

  def is_own_post
    user == post.user
  end
  

  def locked
    if is_young || is_own_post || viewed
      return "unlocked"
    else
      super
    end
  end 

  def self.create(post, user)
    view = View.find_by(post: post, user: user)
    unless view
      view = View.new(post: post, user: user, ad: Ad.all.sample)
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
    view_hash[:ad] = ad.as_json
    view_hash[:is_young] = is_young
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
    view_hash[:ad] = ad.as_json
    view_hash
  end

  def render
    case locked
    when "locked"
      return locked_view
    when "ad"
      return unlocked_view
    when "unlocked"
      return unlocked_view
    else
      return locked_view
    end
  end
  
  
  
  
end
