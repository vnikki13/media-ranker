class WorksController < ApplicationController
  def index
    @albums = Work.where(category: 'album')
    @movies = Work.where(category: 'album')
    @books = Work.where(category: 'album')
  end

  def show
    @work = Work.find_by(id: params[:id])
  end
end
