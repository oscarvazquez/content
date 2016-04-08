require 'rails_helper'

RSpec.describe Review, type: :model do
    before :each do
		@review_params = set_review
	end

	it 'should be able to create a review' do
		@review = create_review(@review_params)
		expect(@review).to be_valid
	end

	it 'should not be able to create a review if rating is nil' do 
		@review_params['rating'] = nil
		@review = create_review(@review_params)
		expect(@review).to be_invalid
	end

	it 'if writer is not set it should not be able to create review' do 
		@review_params['writer'] = nil
		@review = create_review(@review_params)
		expect(@review).to be_invalid
	end

	it 'rating and average rating of receiver should be set' do 
		@review = create_review(@review_params)
		expect(@review.receiver.show_rating).to eq(5)
		last = @review.receiver
		@review_params = set_review
		@review_params['rating'] = 1
		@review_params['receiver'] = last
		@review2 = create_review(@review_params)
		expect(@review2.receiver.show_rating).to eq(3)
	end

end
