class Pitch < ActiveRecord::Base
	belongs_to :user
	belongs_to :business

	validates :price, price: true
	validates :price, :title, :user, :business, presence: true
	validates :pitch, length: {minimum: 250, too_short: "The minimum length for a pitch is 250 characters"}
	
	def just_read!
		self.update_attribute(:read, true)
	end

end
