class BusinessesController < ApplicationController

	def index
		render :json => {message: 'awesome'}
	end

end