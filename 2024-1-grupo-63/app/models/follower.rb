
class Follower < ApplicationRecord
  belongs_to :follower, class_name: "User"
  belongs_to :followed, class_name: "User"
  
  validates :follower, uniqueness: { scope: :followed, message: "already following this user" }, 
if: :followed_has_accepted_follow_request?
  validates :status, inclusion: { in: %w[pending accepted rejected] }
    private
  
  def followed_has_accepted_follow_request?
    FollowRequest.exists?(follower_id: follower_id, followed_id: followed_id, status: "accepted")
  end
  end
  