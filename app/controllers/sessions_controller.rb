class SessionsController < ApplicationController

  def new
  end

  def create
    user = User.authenticate_with_credentials(params[:email], params[:password])
    if user
      session[:user_id] = user.id
      flash[:success] = 'Successfully Logged In!'
      redirect_to '/'
    else
      flash[:warning] = "Invalid Username or Password"
      redirect_to '/login'
    end
  end

  def destroy
   session[:user_id] = nil
   flash[:success] = "Successfully Logged Out!"
   redirect_to '/login'
  end

end
