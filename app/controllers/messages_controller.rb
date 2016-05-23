class MessagesController < ApplicationController
	
	def create
		@post = Message.create message_params
		render :json => {status: "killed it bro"}
	end


	private

	def message_params
    	params.require(:message).permit(:message, :receiver_id, :receiver_type).merge(sender: current_user)
  	end
end
