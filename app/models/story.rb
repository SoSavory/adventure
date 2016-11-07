class Story < ActiveRecord::Base
  belongs_to :user
  has_many :pages, dependent: :destroy
  has_many :convergences, dependent: :destroy
  has_many :aspects, through: :family_aspect


  def build_story_hash
    story_hash = {title: self.title, author: self.user.username, summary: self.summary, levels: [], pages: [], convergences: []}
    pages = Page.where(story_id: self).order('id ASC').pluck(:id, :parent_id, :title, :level, :text)

    levels = Page.where(story_id: self).order('level ASC').pluck(:level).uniq
    convergences = Convergence.where(story_id: self).order('id ASC').pluck(:id, :parent_id, :child_id, :title)

    pages.each do |page|
      story_hash[:pages].push({id: page[0], parent_id: page[1], title: page[2], level: page[3], text: page[4]})
    end

    levels.each do |level|
      story_hash[:levels].push(level)
    end

    convergences.each do |c|
      story_hash[:convergences].push({id: c[0], parent_id: c[1], child_id: c[2], title: c[3]})
    end

    return story_hash.to_json
  end

  def levels
    levels = []
    levels.push( Page.where(story_id: self).pluck('min(level)').first )
    levels.push( Page.where(story_id: self).pluck('max(level)').first )
    return levels
  end

  def has_first_page?
    check = self.pages
    if check.where(level: 0).exists?
      true
    elsif check.where(story_id: self).where(level: nil).exists?
      true
    else
      false
    end
  end

  def first_page
    self.pages.where(level: self.levels[0]);
  end

  def pages_reference
    pages_library = {levels: []}
    pages = Page.where(story_id: self).order('level ASC').pluck(:id, :level, :title)
    levels = []

    pages.each do |level|
      levels.push(level[1])
    end

    levels.uniq!

    levels.each do |level|
      pages_library[:levels].push({level: level, pages: []})
      level_pages = []
      pages.delete_if do |page|
        if page[1] == level
          level_pages.push(page)
          true
        else
          false
        end
      end
      level_object = pages_library[:levels].find{|hash| hash[:level] == level}
      level_pages.each do |page|
        level_object[:pages].push({id: page[0], title: page[2]})
      end
    end
    return pages_library
  end

  def for_convergences_select
      levels = self.pages_reference[:levels]
      levels.map do |level|
        ["Level: #{level[:level]}", level[:pages].map {|c| [c[:title], c[:id] ]}]
      end
  end



end
