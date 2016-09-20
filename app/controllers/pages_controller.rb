class PagesController < ApplicationController
  def new
    @page = Page.new()

  end

  def create
    @page = Page.new(page_params)
    @page.story_id = session[:page_story_id] || session[:story_id]
    @page.parent_id = session[:page_parent_id]
    @first_page_check = params[:first_page_check] || false
    respond_to do |format|
        if @page.save
          session[:page_parent_id] = nil
          session[:page_story_id]  = nil
          session[:story_id]       = nil
          format.js
        end
    end
  end

  def update
    @page = Page.find(params[:id])
    @page.update_attributes(page_params)
    respond_to do |format|
      if @page.save
        session[:page_parent_id] = nil
        format.js {}
      end
    end
  end

  def show
  end

  def edit
    @page = Page.find(params[:id])
    @page.children.build
    respond_to do |format|
      format.js
      format.html
    end
  end

  def add_page
    @page_parent = Page.find(params[:page_parent])
    @page = Page.new()
    session[:page_parent_id] = @page_parent.id || nil
    session[:page_story_id]  = @page_parent.story_id
    respond_to do |format|
      format.js
      format.html
    end
  end

  def show_child_pages
    @page_parent = Page.find(params[:page_parent])
    @page_children = @page_parent.children
    respond_to do |format|
      format.js
      format.html
    end
  end

  def delete
    page = Page.find(params[:id])
    if user_signed_in? && current_user == page.story.user
      page.destroy
      respond_to do |format|
        format.js {render inline: "location.reload();"}
      end
    end
  end

  private

  def page_params
    params.require(:page).permit(:title, :text)
  end

end
