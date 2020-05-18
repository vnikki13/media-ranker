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

    session[:use_id] = user.id
    redirect_to root_path
  end
end
