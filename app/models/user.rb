class User < ApplicationRecord
    has_secure_password

    validates :username, uniqueness: {case_sensitive: false}

    has_many :follower_joins, class_name: "Follow", foreign_key: "followee_id"
    has_many :followers, through: :follower_joins

    has_many :followee_joins, class_name: "Follow", foreign_key: "follower_id"
    has_many :followees, through: :followee_joins

    has_many :posts
    has_many :comments

    def is_following(user_id)
        followees.any? { |f| f.id == user_id}
    end

    def is_followed_by(user_id)
        followers.any? { |f| f.id == user_id}
    end
    
    def follow(user_id)
        unless is_following(user_id)
            followees << User.find(user_id)
        end
    end

    def unfollow(user_id)
            followees.delete(User.find_by(id: user_id))
    end
    

    def profile_metrics
        {
            posts_qty: posts.length,
            followers_qty: followers.length,
            following_qty: followees.length

        }
    end
    

    def followees_ids
        followees.pluck(:id)
    end

    def profile
        p = self.as_json
        p.delete("password_digest")
        p = p.merge(profile_metrics)
        p
    end
    
    
    def feed
        posts = Post.order(updated_at: :desc).where(user_id: followees_ids)
        posts.map do |p| 
            p = p.as_json
            p[:user] = User.find(p["user_id"]).profile
            p
        end
    end
    

    
end
