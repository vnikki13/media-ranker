class UsersController < ApplicationController
  def login_form
    @user = User.new
  end

  def login
    user = User.find_by(username: params[:user][:username])
    if user.nil?
      user = User.new(username: params[:user][:username])
      if user.save
        flash[:welcome] = "Welcome #{user.username}"
      else
        flash.now[:error] = "unable to login"
        render :login_form
        return
      end
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

  def current
    @user = User.find_by(id: session[:user_id])

    if @user.nil?
      flash[:error] = "You must log in to do that"
      redirect_to root_path
      return
    end
  end
end
