class SessionsController < ApplicationController
  def new
  end

  def create
  	if @user = User.find_by_email(params[:email])
	  	if @user.authenticate(params[:password])
	  		session[:user_id] = @user.id
	  		redirect_to root_path, flash: {success: "Welcome back"}
	  	else
	  		redirect_to sessions_new_path flash: {notice: "password is wrong"}
	  	end
	 else
	 	redirect_to sessions_new_path flash: {notice: "Email not found"}
	 end
  end

  def destroy
  	session[:user_id] = nil
  	redirect_to sessions_new_path, notice: "Logged out"
  end
end
