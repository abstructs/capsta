class Post < ApplicationRecord
  belongs_to :user
  has_many :comments, dependent: :destroy
  validates :user_id, presence: true
  has_attached_file :image, styles: { :medium => "640x" }
  validates :image, presence: true
  validates_attachment_content_type :image, content_type: /\Aimage\/.*\z/
  acts_as_votable
  has_many :notifications, dependent: :destroy
  scope :of_followed_users, -> (following_users) { where user_id: following_users }
end
