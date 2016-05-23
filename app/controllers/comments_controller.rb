class CommentsController < ApplicationController

	# before_filter :process_params, only: [:create]

	def create
		@comment = Comment.create comment_params
		@comment.upload_file params[:file]
	end

	def destroy
		Comment.find(params[:id]).destroy
		render :json => {status: 'Success'}
	end


	private

	def comment_params
    	params.require(:comment).permit(:commentable_id, :commentable_type, :comment).merge(commenter: current_user)
  	end

end