class CreateFamilyUsers < ActiveRecord::Migration
  def change
    create_table :family_users do |t|
      t.references :family, index: true
      t.references :user, index: true

      t.timestamps null: false
    end
  end
end
