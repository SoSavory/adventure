class CreateUserFavorites < ActiveRecord::Migration
  def change
    create_table :user_favorites do |t|
      t.references :user, index: true
      t.references :story, index: true

      t.timestamps null: false
    end
  end
end
