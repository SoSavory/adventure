# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

Story.create(title: "Test Story", summary: "Once upon a time... There was a test story")

Page.create(title: "The first page", text: "Once upon a time there was a second page", level: 0, story: Story.first)

  for level in 1..3
    for page in 0..2
      Page.create(title: "This is the title of page: #{page} in level: #{level}",
       text: "This is the text of page: #{page} in level: #{level}",
        level: level, parent_id: level,
        story: Story.first)
    end
  end
