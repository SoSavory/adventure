class FamilyAdmin < ActiveRecord::Base
  belongs_to :family
  belongs_to :admin, class_name: "User"
end
