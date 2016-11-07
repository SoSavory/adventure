class CreateStoryAspects < ActiveRecord::Migration
  def change
    create_table :story_aspects do |t|
      t.references :story, index: true
      t.references :aspect, index: true
      t.timestamps null: false
    end
  end
end
