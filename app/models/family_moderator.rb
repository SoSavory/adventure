class FamilyModerator < ActiveRecord::Base
  belongs_to :family
  belongs_to :moderator, class_name: "User"
end
