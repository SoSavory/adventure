class CreateStories < ActiveRecord::Migration
  def change
    create_table :stories do |t|
      t.string     :title,      null: false
      t.text       :summary,    null: false
      t.references :user,       null: false,   index: true
      t.boolean    :published, default: false, index: true

      t.timestamps          null: false
    end
  end
end
