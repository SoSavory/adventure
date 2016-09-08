class CreatePages < ActiveRecord::Migration
  def change
    create_table :pages do |t|
      t.references :story,              null: false, index: true
      t.references :parent,                          index: true
      t.string     :title,              null: false
      t.text       :text,               null: false
      t.integer    :level,                           index: true


      t.timestamps                      null: false
    end
  end
end
