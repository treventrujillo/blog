class PagesController < ApplicationController
  # Responsible for showing all pages
  def index
    # local var only available in method
    # if we want view to have access to variable, make an instance variable
    @pages = Page.all
  end

  # Responsible for showing specific page
  def show
    @page = Page.find(params[:id])
    #render :show - app/views/pages/show.html.erb
  end

  # Responsible for showing a form to edit and existing page
  def edit
    @page = Page.find(params[:id])

  end

  # Responsible for showing a form to create a page
  def new
    @page = Page.new
  end

  # Responsible for saving a new record in our database
  def create
    # Strong params
    page = Page.new(page_params)
    # executes SQL to try to save new page in database
    if page.save
      # success - new record in databse
      redirect_to page_path(page)
    else
      # fail - failed to execute SQL
      render :new
    end
  end

# Responsible for updating values of pre-existing record
def update
  @page = Page.find(params[:id])
  if @page.update(page_params)
    # page successfully updated
    # generate url to page
    redirect_to page_path(@page)
  else
    # page failed to update
    render :edit
  end
end

def destroy
  page = Page.find(params[:id])
  page.destroy
  redirect_to pages_path
end

  private
    def page_params
      params.require(:page).permit(:title, :author, :body, :private)
    end
end
