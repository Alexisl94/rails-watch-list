class BookmarksController < ApplicationController
  def new
    @bookmark = Bookmark.new
    @list = List.find(params[:list_id])
  end

  def create
    @bookmark = Bookmark.new(params_bookmark)
    @movie = Movie.find(params[:bookmark][:movie_id])
    @bookmark.list = List.find(params[:list_id])
    @list = @bookmark.list
    @bookmark.movie = @movie
    if @bookmark.save
      redirect_to list_path(@list), notice: "Bookmark added"
    else
      render "lists/show", status: :unprocessable_entity
    end
  end

  def destroy
    @bookmark = Bookmark.find(params[:id])
    @bookmark.destroy
    redirect_to list_path(@bookmark.list)
  end

  private

  def params_bookmark
    params.require(:bookmark).permit(:comment, :movie_id)
  end
end
