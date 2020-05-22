class HomepagesController < ApplicationController
  def index
    @spotlight = Work.top_work
    @top_albums = Work.top_ten("album")
    @top_books = Work.top_ten("book")
    @top_movies = Work.top_ten("movie")
    @user = User.find_by(id: session[:user_id])
  end
end
