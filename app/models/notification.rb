class Notification < ActiveRecord::Base
  belongs_to :event, polymorphic: true
  belongs_to :initiator, polymorphic: true
  belongs_to :receiver, polymorphic: true



  scope :unread, lambda {|| where("status = false")}

end
