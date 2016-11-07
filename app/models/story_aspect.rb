class StoryAspect < ActiveRecord::Base
  belongs_to :story
  belongs_to :aspect
end
