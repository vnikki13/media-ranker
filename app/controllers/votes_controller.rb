class VotesController < ApplicationController

  before_action :require_login

  def create
    @vote = Vote.new(work_id: params[:vote][:work_id], user_id: session[:user_id], voted_on: Date.today)
    if @vote.save
      flash[:success] = "Successfully upvoted!"
    else
      flash[:warning] = 'A problem occured: Could not upvote'
      flash[:details] = @vote.errors.messages
    end

    redirect_to works_path
  end
end
