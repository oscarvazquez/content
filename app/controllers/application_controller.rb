class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
	protect_from_forgery with: :exception
	
	respond_to :json

	helper_method :current_user

	def verify_email user
		user.update_attribute(:confirmation_email, true)
	end

	def current_user
		@current_user ||= User.find(session[:user_id]) if session[:user_id]
	end

	def has_access
		if not current_user
			render :json => {status: 'error', loggedIn: 'false', message: 'Session timed out please login'}
		end
	end

end
