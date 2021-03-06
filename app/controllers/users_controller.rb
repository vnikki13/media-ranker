class UsersController < ApplicationController
  def create
    auth_hash = request.env["omniauth.auth"]
    user = User.find_by(uid: auth_hash[:uid], provider: "github")

    if user
      flash[:success] = "Logged in as returning user #{user.username}"
    else
      user = User.build_from_github(auth_hash)

      if user.save
        flash[:success] = "Logged in as new user #{user.username} hi baby"
      else
        flash[:warning] = "Could not create new user account:"
        flash[:details] = user.errors.messages
        return redirect_to root_path
      end
    end

    session[:user_id] = user.id
    return redirect_to root_path
  end

  def index
    @users = User.all
  end

  def show
    @user = User.find_by(id: params[:id])
  end

  # def login_form
  #   @user = User.new
  # end

  # def login
  #   username = params[:user][:username]
  #   @user = User.find_by(username: username)
  #   if @user
  #     session[:user_id] = @user.id
  #     flash[:success] = "Successfully logged in as existing user #{username}"
  #   else
  #     @user = User.new(username: username, joined: Date.today)
  #     if @user.save
  #       flash[:success] = "Successfully created new user #{username} with ID #{@user.id}"
  #       session[:user_id] = @user.id
  #     else
  #       flash.now[:warning] = "A problem occured: Could not log in"
  #       flash.now[:details] = @user.errors.messages

  #       render :login_form
  #       return
  #     end
  #   end

  #   redirect_to root_path
  # end

  def destroy
    if session[:user_id]
      user = User.find_by(id: session[:user_id])
      unless user.nil?
        session[:user_id] = nil
        flash[:success] = "Successfully logged out"
      else
        session[:user_id] = nil
        flash[:danger] = "Error Unknown User"
      end
    else
      flash[:danger] = "You must be logged in to logout"
    end
    redirect_to root_path
  end
end
