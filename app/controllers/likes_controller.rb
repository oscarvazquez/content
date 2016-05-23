class LikesController < ApplicationController

	def create
		@like = Like.create like_params
	end

	def destroy
		Like.find(params[:id]).destroy
		render :json => {status: 'Success'}
	end


	private

	def like_params
    	params.require(:like).permit(:likeable_id, :likeable_type).merge(liker: current_user)
  	end

end