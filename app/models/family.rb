class Family < ActiveRecord::Base
  belongs_to :admin, class_name: "User"
  has_many :stories, through: :family_story
  has_many :aspects, through: :family_aspect
  has_many :users, through: :family_user
  has_many :moderators, through: :family_moderator
end
