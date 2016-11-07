class ConvergencesController < ApplicationController

  def new
    @convergence = Convergence.new()
  end

  def add_convergence
    @library = Story.find(session[:story_id]).for_convergences_select
    puts @library
    @convergence = Convergence.new()
    respond_to do |format|
      format.js
    end
  end


  def create
    @convergence = Convergence.new(convergence_params)
    @convergence.story_id = session[:story_id]
    respond_to do |format|
        if @convergence.save
          format.js
        end
    end
  end

  def delete
    @convergence = Convergence.find(id)
    @convergence.destroy
    respond_to do |format|
      format.js {render inline: "location.reload();"}
    end
  end

  private

  def convergence_params
    params.require(:convergence).permit(:parent_id, :child_id, :title)
  end

end
