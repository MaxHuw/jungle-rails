class UsersController < ApplicationController

  def new
  
  end

  def create
    user = User.new(
      name: params[:name],
      email: params[:email],
      password_digest: params[:password]
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


# create_table "users", force: :cascade do |t|
#   t.string   "name"
#   t.string   "email"
#   t.string   "password_digest"
#   t.datetime "created_at",      null: false
#   t.datetime "updated_at",      null: false
# end