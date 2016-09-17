class UsersController < ApplicationController
  def show
    @user = User.find(params[:id])
    user_stories = @user.stories.order('id DESC')
    @published_stories = user_stories.where(published: true)
    if user_signed_in? && current_user.id == @user.id
      puts "true"
      @var = "private"
      @unpublished_stories = user_stories.where(published: false)
    else
      @var = 'public'
    end
  end
end
