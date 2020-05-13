class WorksController < ApplicationController
  def index
    @albums = Work.where(category: 'album')
    @movies = Work.where(category: 'album')
    @books = Work.where(category: 'album')
  end

  def show
    @work = Work.find_by(id: params[:id])
  end

  def edit
    @work = Work.find_by(id: params[:id])
  end

  def update
    @work = Work.find_by(id: params[:id])
    if @work.nil?
      head :not_found
    elsif @work.update(work_params)
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
