class User < ApplicationRecord
    has_many :follower_joins, class_name: "Follow", foreign_key: "followee_id"
    has_many :followers, through: :follower_joins

    has_many :followee_joins, class_name: "Follow", foreign_key: "follower_id"
    has_many :followees, through: :followee_joins

    def follow(user_id)
        followees << User.find(user_id)
    end
end
