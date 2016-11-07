class FamilyStory < ActiveRecord::Base
  belongs_to :family
  belongs_to :story
end
