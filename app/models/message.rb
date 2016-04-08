class Message < ActiveRecord::Base
	belongs_to :sender, polymorphic: true
	belongs_to :receiver, polymorphic: true

	scope :unread, lambda {|| where("status = false")}

end
