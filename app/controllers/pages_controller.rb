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
    @page_parent = Page.where(id: params[:page_parent]).pluck(:id, :story_id)[0]
    @page = Page.new()
    session[:page_parent_id] = @page_parent[0] || nil
    session[:page_story_id]  = @page_parent[1]
    respond_to do |format|
      format.js
      format.html
    end
  end

  def show_relations
    current_page = params[:current_page]
    page_parent = Page.find(current_page).parent_id
    page_children = Page.where(parent_id: current_page).pluck(:id, :title)
    page_child_convergences = Convergence.where(child_id: current_page).pluck(:id, :title, :parent_id)
    page_parent_convergences = Convergence.where(parent_id: current_page).pluck(:id, :title, :child_id)
    respond_to do |format|
      format.js
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
