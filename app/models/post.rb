class Post < ApplicationRecord
  belongs_to :user

  def with_user
    p = self.as_json
    p[:user] = user
    p
  end
  
end
