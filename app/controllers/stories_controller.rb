class StoriesController < ApplicationController
  def new
    @story = Story.new()
  end

  def create
    @story = Story.new(story_params)
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
      redirect_to @story
    end
  end

  def show
    @story = Story.find(params[:id]).build_story_hash
  end

  private

    def story_params
      params.require(:story).permit(:title, :summary)
    end

end
