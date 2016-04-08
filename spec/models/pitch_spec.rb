require 'rails_helper'

RSpec.describe Pitch, type: :model do
    before :each do
		@pitch_params = set_pitch
	end

	it 'should be able to create a pitch' do 
		@pitch = create_pitch(@pitch_params)
		expect(@pitch).to be_valid
	end

	it "if length is 1000, price can't be less than 100" do 
		@pitch_params['price'] = 99
		@pitch_params['length'] = 501
		@pitch = create_pitch(@pitch_params)
		expect(@pitch).to be_invalid
	end

	it "if length is between 250 and 500, price can't be less than 50" do 
		@pitch_params['price'] = 45
		@pitch_params['length'] = 275
		@pitch = create_pitch(@pitch_params)
		expect(@pitch).to be_invalid
	end

	it "if length is between 0 and 250, price can't be less than 25" do 
		@pitch_params['price'] = 20
		@pitch_params['length'] = 225
		@pitch = create_pitch(@pitch_params)
		expect(@pitch).to be_invalid
	end

	it "if pitch is less than 250 characters it should fail" do 
		@pitch_params['pitch'] = 'something new'
		@pitch = create_pitch(@pitch_params)
		expect(@pitch).to be_invalid
	end


	pending 'if you look for the article it should be marked as read' do 
		@pitch = create_pitch(@pitch_params)
		pitch = Pitch.find(@pitch.id)
		@pitch.just_read!
		expect(pitch.read).to eq(true)
	end

end
