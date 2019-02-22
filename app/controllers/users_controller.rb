class UsersController < ApplicationController

  def new
  
  end

  def create
    user = User.new(
      name: params[:name],
      email: params[:email],
      password: params[:password];
    )

    if user.save
      session[:user_ide] = user.id
      flash[:sucess] = "Successfully Created User!"
      redirect_to '/'
    else
      flash[:warning] = "Invalid Email or Password"
      redirect_to '/user/new'
    end
  end
end
