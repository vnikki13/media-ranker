class UsersController < ApplicationController
  def login_form
    @user = User.new
  end

  def login
    user = User.find_by(username: params[:user][:username])
    if user.nil?
      user = User.new(username: params[:user][:username])
      if !user.save
        flash[:error] = "unable to login"
        redirect_to root_path
        return
      end
      flash[:welcome] = "Welcome #{user.username}"
    else
      flash[:welcome] = "Welcome back #{user.username}"
    end

    session[:user_id] = user.id
    redirect_to root_path
  end

  def logout
    if session[:user_id]
      user = User.find_by(id: session[:user_id])
      unless user.nil?
        session[:user_id] = nil
        flash[:notice] = "Goodbye #{user.username}"
      else
        session[:user_id] = nil
        flash[:notice] = "Error Unknown User"
      end
    else
      flash[:error] = "You must be logged in to logout"
    end
    redirect_to root_path
  end
end
