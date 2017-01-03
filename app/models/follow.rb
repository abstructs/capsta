class Follow < ApplicationRecord
  belongs_to :user, foreign_key: 'follower_id', class_name: 'User'
  belongs_to :following, foreign_key: 'following_id', class_name: 'User'
end
