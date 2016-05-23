class PostsController < ApplicationController
	
	def create
		@post = Post.create post_params
		@post.upload_file params[:file]
	end


	private

	def post_params
    	params.require(:post).permit(:post).merge(writer: current_user)
  	end
end
