class UsersController < ApplicationController
 
  before_action :has_access, only: [:show]

  def index
  end

  def new
  end

  def show
    @user = User.find(params[:id])
  end

  def create
    @user = User.new user_params
    if @user.save
      render :json => {message: 'User succesfully created! Redirecting to login... ', status: 'success', email: "Please verify your email address before logging in: #{@user.email}"}
    else
      render :json => {message: @user.errors.full_messages}
    end
  end

  def email_verification 
    @user = User.find_by(email_token: params[:token])
    if @user 
      verify_email @user
      render :json => {status: "success", message: "Thanks for validating your email #{@user.name}"}
    else
      render :json => {status: "error", message: "An error occured while trying to proccess your request"}
    end
  end

  def add_location
    @user = User.find(params[:location][:userID])
    puts 'this should be working'
    puts params[:location]
    if @user.set_local! params[:location]
      render :json => {message: 'Location updated', user: @user}, status: :created
    else 
      render :json => {error: "An error occured while trying to updaet location"}, status: :bad_request
    end
  end

  private 
  
  def user_params
    params.require(:user).permit(:first_name, :last_name, :email, :password, :password_confirmation)
  end

end
