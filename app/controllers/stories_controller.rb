class StoriesController < ApplicationController

  before_action :authenticate_user!, only: [:new, :create, :edit, :update]
  def new
    @story = Story.new()
  end

  def create
    @story = Story.new(story_params)
    @story.user = current_user
    if @story.save
      session[:page_parent_id] = nil
      session[:page_story_id]  = nil
      session[:story_id]       = nil
      redirect_to edit_story_path(@story)
    end
  end

  def edit
    @story = Story.find(params[:id])
    if @story.has_first_page?
    else
      @page = Page.new()
      session[:story_id] = @story.id
    end
  end

  def update
    @story = Story.find(params[:id])
    @story.update_attributes(story_params)
    if @story.save
      session[:page_parent_id] = nil
      session[:page_story_id]  = nil
      session[:story_id]       = nil
      redirect_to story_edit_path(@story)
    end
  end

  def show
    @story = Story.find(params[:id]).build_story_hash
  end

  def publish_story
    story = Story.find(params[:id])
    if current_user && current_user == story.user
      story.update_attributes(published: true)
      story.save
      respond_to do |format|
        format.js {render inline: "location.reload();"}
      end
    end
  end

  def index
  end

  private

    def story_params
      params.require(:story).permit(:title, :summary, :published)
    end

end
