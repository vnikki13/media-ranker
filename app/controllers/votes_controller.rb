class VotesController < ApplicationController
  def create
    @vote = Vote.new(work_id: params[:vote][:work_id], user_id: session[:user_id], voted_on: Date.today)
    if @vote.save
      flash[:success] = "upvote successful"
    else
      flash[:error] = 'A problem occured: Could not upvote'
    end

    redirect_to works_path
  end
end
