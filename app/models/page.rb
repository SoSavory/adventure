class Page < ActiveRecord::Base
  belongs_to :story
  has_many :children, class_name: "Page",
                      foreign_key: "parent_id", dependent: :destroy
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


  def get_parent_convergences_object
    convergences = Convergence.where(parent_id: self.id)
      .pluck(:id, :title, :story_id, :parent_id, :child_id)
    convergence_objects = []
    convergence_pages = []
    convergences.each do |c|
      pages = Page.where(id: c[3]).pluck(:id, :title, :level)
      convert_pages = []
      pages.each do |p|
        convert_pages.push({id: p[0], title: p[1], level: p[2]})
      end
      convergence_objects.push(
        {id: c[0], title: c[1], story_id: c[2],
           parent_id: c[3], child_id: c[4], pages: convert_pages
        })
    end
    return convergence_objects
  end

  def get_child_convergences_object
    convergences = Convergence.where(child_id: self.id)
      .pluck(:id, :title, :story_id, :parent_id, :child_id)
    convergence_objects = []
    convergences.each do |c|
      pages = Page.where(id: c[4]).pluck(:id, :title, :level)
      convert_pages = []
      pages.each do |p|
        convert_pages.push({id: p[0], title: p[1], level: p[2]})
      end
      convergence_objects.push(
        {id: c[0], title: c[1], story_id: c[2],
           parent_id: c[3], child_id: c[4], pages: convert_pages
         })
    end
    return convergence_objects
  end
end
