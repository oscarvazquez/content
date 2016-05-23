class Review < ActiveRecord::Base
	belongs_to :receiver, polymorphic: true
	belongs_to :writer, polymorphic: true
	belongs_to :job
	
	has_many :comments, as: :commentable
	has_many :likes, as: :likeable

	validates :job_id, presence: true
	validates :receiver, :writer, :rating, presence: true
	
	# This one is kind of working except for when I test it with rspec.
	# It's still incomplete I have to make sure that there could only be two reviews
	# per job, one for the user and one for the business
	# validates :writer, writer: :true

	
	after_create :update_receiver!, :notify_user

	private

	def update_receiver!
		new_count = receiver.rating_count + 1
		new_total = receiver.rating + rating
		receiver.update_attribute(:rating_count, new_count)
		receiver.update_attribute(:rating, new_total)
	end

	def delete_review!
		new_count = receiver.rating_count - 1
		new_total = receiver.rating - rating
		receiver.update_attribute(:rating_count, new_count)
		receiver.update_attribute(:rating, new_total)
		destroy
	end

	def notify_user
		message = "wrote you a new review: " + review
	  	receiver.get_notified self, writer, message
	end

end
