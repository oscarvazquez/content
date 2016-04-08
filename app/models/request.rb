class Request < ActiveRecord::Base
  belongs_to :business
  belongs_to :category

  after_create :notify_users


	private

	def notify_users
		message = "created a new request: " + title
		self.category.users.each do |u|
	  		u.get_notified self, business, message
		end
	end

end
