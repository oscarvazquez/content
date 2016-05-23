class SessionsController < ApplicationController
	def create
		unless user_login
			business_login
		end
	end

	def createO
		user = User.from_omniauth(env["omniauth.auth"])	
	end

	def destroy
		session[:user_id] = false
		render :json => {status: 'success', message: 'succesfully logged out'}
	end

	private

	def user_login
		@user = User.find_by_email(params[:user][:email])
		if @user 
			if @user.authenticate(params[:user][:password])
				if @user.email_verified?
					session[:user_id] = @user.id
					render :json => {status: 'success', user: @user.as_json(:only => [:id, :email])}
				else 
					render :json => {status: 'error', message: 'Please verify your email before logging in'}
				end
			else 
				render :json => {status: 'error', message: "Credentials do not match, either email or password was entered incorrectly"}
			end
		else 
			return false
		end
	end

	def business_login
		@business = Business.find_by_email(params[:user][:email])
		if @business
			if @business.authenticate(params[:user][:password])
				if @business.email_verified?
					render :json => {status: 'success'}
				else
					render :json => {status: 'error', message: 'Please verify your email before logging in'}
				end
			else 
				render :json => {status: 'error', message: "Credentials do not match, either email or password was entered incorrectly"}
			end
		else
			render :json => {status: 'error', message: "Credentials do not match, either email or password was entered incorrectly"}
		end
	end

end
