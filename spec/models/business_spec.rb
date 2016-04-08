require 'rails_helper'

RSpec.describe Business, type: :model do
  	before :each do
		@biz_params = set_business
	end
	after :each do 
		@biz.destroy
	end
	
	it "should be able to create new business " do 
		@biz = create_business(@biz_params)
		expect(@biz).to be_valid
	end 

	it 'should not be able to create a new business if name is blank' do 
		@biz_params['name'] = ''
		@biz = create_business(@biz_params)
		expect(@biz).to be_invalid
	end

	it 'should not save if email is already in use' do
		@biz = create_business(@biz_params)
		@biz2 = create_business(@biz_params)
		expect(@biz2).to be_invalid
	end

	it 'should not save if email has wrong syntax' do 
		@biz_params['email'] = 'alskdjfajl'
		@biz = create_business(@biz_params)
		expect(@biz).to be_invalid
	end

	it 'should not be able to create a new business if email is invalid' do
		@biz_params['email'] = 'alskdnva'
		@biz = create_business(@biz_params)
		expect(@biz).to be_invalid
	end

	pending 'should not be able to create a new business if address is invalid' do 
		@biz_params['zip_code'] = 'alskdj'
		@biz_params['street_address'] = 'lasdkfj'
		@biz_params['state'] = 'alsfdj'
		@biz = create_business(@biz_params)
		expect(@biz).to be_invalid
	end

	it "when the business is created the admin profile should be created automatically" do
		@biz = create_business(@biz_params)
		expect(@biz.admins.count).to eq(1)
		expect(@biz.admins.first.email).to eq(@biz.email)
	end
end
