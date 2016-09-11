class Story < ActiveRecord::Base
  belongs_to :user
  has_many :pages


  def build_story_hash
    story_hash = {title: self.title, author: self.user.username, summary: self.summary, levels: [], pages: []}
    pages = Page.where(story_id: self).order('id ASC').pluck(:id, :parent_id, :title, :level, :text)

    levels = Page.where(story_id: self).order('level ASC').pluck(:level).uniq

    pages.each do |page|
      story_hash[:pages].push({id: page[0], parent_id: page[1], title: page[2], level: page[3], text: page[4]})
    end

    levels.each do |level|
      story_hash[:levels].push(level)
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

  end



end
