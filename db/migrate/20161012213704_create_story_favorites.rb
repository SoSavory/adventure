class CreateStoryFavorites < ActiveRecord::Migration
  def change
    create_table :story_favorites do |t|

      t.references :story_id, index: true
      t.references :user_id, index: true

      t.timestamps null: false
    end
  end
end
