class CreateFamilyStories < ActiveRecord::Migration
  def change
    create_table :family_stories do |t|
      t.references :family, index: true
      t.references :story, index: true
      t.timestamps null: false
    end
  end
end
