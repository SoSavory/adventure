class CreateUserFavorites < ActiveRecord::Migration
  def change
    create_table :user_favorites do |t|
      t.references :follower, index: true
      t.references :followed, index: true
      t.timestamps null: false
    end
  end
end
