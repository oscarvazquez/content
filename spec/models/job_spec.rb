require 'rails_helper'

RSpec.describe Job, type: :model do
	before :each do
		@job_params = set_job
	end
	it 'should be able to create a job' do
		@job = create_job(@job_params)
		expect(@job).to be_valid
	end

	# it 'should not allow me to create 3 reviews for one job' do
	# 	@job = create_job(@job_params)
	# 	@review_params = set_review
	# 	@review_params.delete('job')
	# 	b = @job.reviews.create(@review_params)
	# 	a = @job.reviews.create(@review_params)
	# 	@review = @job.reviews.create(@review_params)
	# 	@review.job
	# 	puts @review.errors.full_messages
	# 	expect(@review).to eq(3)
	# end
end
