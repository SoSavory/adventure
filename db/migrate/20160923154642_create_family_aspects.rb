class CreateFamilyAspects < ActiveRecord::Migration
  def change
    create_table :family_aspects do |t|
      t.references :family, index: true
      t.references :aspect, index: true
      t.timestamps null: false
    end
  end
end
