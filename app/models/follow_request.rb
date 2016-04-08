class FollowRequest < ActiveRecord::Base
  belongs_to :follower, polymorphic: true
  belongs_to :followed, polymorphic: true

  scope :unread, lambda {|| where("status = false")}

end
