class UsersController < ApplicationController
  
  def index
    @users = User.all
  end

  def login_form
    @user = User.new
  end

  def login
    username = params[:user][:username]
    user = User.find_by(username: username)
    if user
      session[:user_id] = user.id
      flash[:success] = "Successfully logged in as existing user #{username}"
    else
      user = User.new(username: username, joined: Date.today)
      if user.save
        flash[:success] = "Successfully created new user #{username} with ID #{user.id}"
        session[:user_id] = user.id
      else
        flash[:error] = "A problem occured: Could not log in"
        redirect_to login_path
        return
      end
    end

    redirect_to root_path
  end

  def logout
    if session[:user_id]
      user = User.find_by(id: session[:user_id])
      unless user.nil?
        session[:user_id] = nil
        flash[:notice] = "Successfully logged out"
      else
        session[:user_id] = nil
        flash[:notice] = "Error Unknown User"
      end
    else
      flash[:error] = "You must be logged in to logout"
    end
    redirect_to root_path
  end

  def current
    @user = User.find_by(id: session[:user_id])

    if @user.nil?
      flash[:error] = "You must log in to do that"
      redirect_to root_path
      return
    end
  end
end
