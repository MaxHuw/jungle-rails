class UsersController < ApplicationController

  def new
  
  end

  def create
    user = User.new(
      first_name: params[:first_name],
      last_name: params[:last_name],
      email: params[:email],
      password: params[:password]
    )

    if user.save
      session[:user_id] = user.id
      flash[:sucess] = "Successfully Created User!"
      redirect_to '/'
    else
      flash[:warning] = "Invalid Email or Password"
      redirect_to '/user/new'
    end
  end
end
