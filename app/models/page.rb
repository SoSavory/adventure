class Page < ActiveRecord::Base
  belongs_to :story
  has_many :children, class_name: "Page",
                      foreign_key: "parent_id"
  belongs_to :parent, class_name: "Page"

  after_create :set_level

  def get_level
    level = 0
    initial_page = self
    while initial_page.parent_id? do
      level +=1
      initial_page = Page.find(initial_page.parent_id)
    end
    return level
  end

  def set_level
    self.level = self.get_level
    self.save
  end

end
