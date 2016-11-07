class CreateFamilyModerators < ActiveRecord::Migration
  def change
    create_table :family_moderators do |t|
      t.references :family, index: true
      t.references :moderator, index: true
      t.timestamps null: false
    end
  end
end
