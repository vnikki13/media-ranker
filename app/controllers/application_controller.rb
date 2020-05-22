class ApplicationController < ActionController::Base

  def current_user
    @current_user = User.find_by(id: session[:user_id])
  end

  def require_login
    if current_user.nil?
      flash[:warning] = "A Problem occured: You must log in to do that"
      redirect_back(fallback_location: "/")
    end
  end
end
