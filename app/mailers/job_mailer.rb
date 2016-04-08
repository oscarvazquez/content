class JobMailer < ActionMailer::Base
	default from: "jo@zwaig.com"

	def job_accepted(job)
		@job = job
  		@url  = "http://awesome.com/#{@job.id}"
  		mail(to: @job.user.email, subject: "You have just accepted a job from #{@job.business.name}")
		mail(to: @job.business.email, subject: "#{@job.user.name} is ready \for the job \and wont let you down")
	end

	def job_one_day_out(job)
		@job = job
		if not @job.completed
  			@url  = "http://awesome.com/#{@job.id}"
  			mail(to: @job.user.email, subject: "#{@job} is due tomorrow bro!")
  			mail(to: @job.business.email, subject: "#{@job.user.name} is hard at work making sure he meets his deadline}")
		end
	end

	def job_due(job)
		@job = job
		if not @job.complted
  			@url  = "http://awesome.com/#{@job.id}"
  			mail(to: @job.user.email, subject: "@job is due today homie!")
  			mail(to: @job.business.email, subject: "#{@job.business.name} is cutting it close and trying is hardest to get it done")
  		end
	end

	def job_past_due(job)
		@job = job
		if not @job.completed
			@url  = "http://awesome.com/#{@job.id}"
  			mail(to: @job.user.email, subject: "@job was due two days ago you letting me down bro")
  			mail(to: @job.business.email, subject: "The dude is getting docked, Ill handle him bro")
  		end
	end

	def job_completed(job)
		@job = job
  		@url  = "http://awesome.com/#{@job.id}"
  		mail(to: @job.user.email, subject: "@job was succesfully completed please leave a review of your experience")
  		mail(to: @job.business.email, subject: "@job was succesfully completed please leave a review of your experience")
	end
end