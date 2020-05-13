class WorksController < ApplicationController
  def index
    @books = Work.where(category: 'book')
    @albums = Work.where(category: 'album')
    @movies = Work.where(category: 'movie')

  end

  def show
    @work = Work.find_by(id: params[:id])
  end

  def edit
    @work = Work.find_by(id: params[:id])
  end

  def update
    @work = Work.find_by(id: params[:id])
    if @work.update(work_params)
      redirect_to work_path(@work)
    else
      render :new
    end
  end

  private
  
  def work_params
    return params.require(:work).permit(:category, :title, :creator, :publication_year, :description)
  end
end
