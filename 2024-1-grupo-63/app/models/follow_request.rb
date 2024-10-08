class FollowRequest < ApplicationRecord
  belongs_to :follower, class_name: "User"
  belongs_to :followed, class_name: "User"

    
  validates :status, inclusion: { in: %w(pending accepted rejected status) }
end
