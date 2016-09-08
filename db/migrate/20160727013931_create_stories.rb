class CreateStories < ActiveRecord::Migration
  def change
    create_table :stories do |t|
      t.string :title,      null: false
      t.text   :summary,    null: false

      t.timestamps          null: false
    end
  end
end
