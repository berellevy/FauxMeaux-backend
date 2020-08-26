class User < ApplicationRecord
    has_secure_password

    validates :username, uniqueness: {case_sensitive: false}

    has_many :follower_joins, class_name: "Follow", foreign_key: "followee_id"
    has_many :followers, through: :follower_joins

    has_many :followee_joins, class_name: "Follow", foreign_key: "follower_id"
    has_many :followees, through: :followee_joins

    has_many :posts
    has_many :comments


    def follow(user_id)
        followees << User.find(user_id)
    end

    def followees_ids
        followees.pluck(:id)
    end

    def profile
        p = self.as_json
        p.delete("password_digest")
        p
    end
    
    
    def feed
        posts = Post.order(updated_at: :desc).where(user_id: followees_ids)
        posts.map do |p| 
            p = p.as_json
            p[:user] = User.find(p["user_id"]).as_json
            p
        end
    end
    

    
end
