class WikisController < ApplicationController
  def index
    @wikis = Wiki.all
    authorize @wikis
  end

  def show
    @wiki = Wiki.find(params[:id])
    authorize @wiki 
  end

  def new
    @wiki = Wiki.new
    authorize @wiki 
  end
  def create
     #@wiki = Wiki.new(params.require(:wiki).permit(:title, :body))
      @wiki = current_user.wikis.build(params.require(:wiki).permit(:title, :body))
      @wiki.user_id = current_user.id
      authorize @wiki 
     if @wiki.save!
       flash[:notice] = "Wiki was saved."
       redirect_to @wiki
     else
       flash[:error] = "There was an error saving the wiki. Please try again."
       render :new
     end
   end

  def edit
     @wiki = Wiki.find(params[:id])
     authorize @wiki
  end

  def update
     @wiki = Wiki.find(params[:id])
     authorize @wiki
     if @wiki.update_attributes(params.require(:wiki).permit(:title, :body))
       flash[:notice] = "Wiki was updated."
       redirect_to @wiki

     else
       flash[:error] = "There was an error saving the wiki. Please try again."
       render :edit
     end
   end
end
