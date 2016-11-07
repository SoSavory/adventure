class CreateAspects < ActiveRecord::Migration
  def change
    create_table :aspects do |t|
      t.string :title, null: false
      t.timestamps null: false
    end
  end
end
