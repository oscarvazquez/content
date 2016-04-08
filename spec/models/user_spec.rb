require 'rails_helper'
RSpec.describe User do
	before :each do
		@params = set_user
	end
	after :each do 
		@user.destroy
	end

	it "should be able to create new user " do 
		@user = create_user(@params)
		expect(@user).to be_valid
	end 

	it "should not save if first_name field is blank." do
		@params['first_name'] = ''
		@user = create_user(@params)
		expect(@user).to be_invalid
	end
	
	it "should not save if last_name field is blank." do
		@params['last_name'] = ''
		@user = create_user(@params)
		expect(@user).to be_invalid
	end
	
	it "should not save a invalid email."  do 
		@params['email'] = 'oscaroscar'
		@user = create_user(@params)
		expect(@user).to be_invalid
	end
	
	it "should not save if email is already used" do 
		@user = create_user(@params)
		@user2 = create_user(@params)
		expect(@user2).to be_invalid
	end

	pending "should update social" do
		@user = create_user(@params)
		@social = Hash.new
		@social['facebook'] = "facebook.com/oscar"
		@social['twitter'] = "twitter.com/oscar"
		@social['linked_in'] = "linkedin.com/oscar"
		@social['website'] = "oscar.tech"
		@user.update_user!(@social)
		@user2 = User.find(@user.id)
		expect(@user2.facebook).to eq('facebook.com/oscar')
		expect(@user2.twitter).to eq('twitter.com/oscar')
		expect(@user2.linked_in).to eq("linkedin.com/oscar")
		expect(@user2.website).to eq("oscar.tech")
	end

end