require 'rufus-scheduler'
require "date"
class Job < ActiveRecord::Base
	belongs_to :user
	belongs_to :business
	belongs_to :category
	belongs_to :subcategory
	has_many :reviews

	validates :price, price: true
	validates :price, :user, :business, :timeline, presence: true

	after_create :job_accepted, :set_reminder, :job_completed

	def pending!
		update_attribute(:status, 1)
	end	

	def complete!
		if not completed
			update_attribute(:time_completed, Time.now - created_at)
			update_attribute(:completed, true)
			update_attribute(:status, 2)
			business.increment!(:jobs_completed, by=1)
			business.save
			user.increment!(:jobs_completed, by=1)
			user.save
			job_completed
		end
	end

	scope :in_production, lambda {|| where("status = 0")}
	scope :pending, lambda {|| where("status = 1")}
	scope :completed, lambda {|| where("status = 2")}

# 0 == In production
# 1 == Pending Review
# 2 == Completed

	private

	def job_accepted
		# JobMailer.job_accepted(self)
	end

	def set_reminder
		# one_day = (self.timeline - 1).to_s + 'd'
		# two_days_past_due = (self.timeline + 2).to_s + 'd'
		# SCHEDULER.in(one_day) do 
		# 	JobMailer.job_one_day_out(self)
		# end
		# SCHEDULER.in(self.timeline.to_s + 'd') do 
		# 	JobMailer.job_due(self)
		# end
		# SCHEDULER.in(two_days_past_due) do 
		# 	JobMailer.job_past_due(self)
		# end
	end

	def job_completed
		if self.completed
			# JobMailer.job_completed(self)
		end
	end

end
