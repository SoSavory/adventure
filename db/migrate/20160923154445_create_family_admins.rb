class CreateFamilyAdmins < ActiveRecord::Migration
  def change
    create_table :family_admins do |t|
      t.references :family, index: true
      t.references :admin, index: true
      t.timestamps null: false
    end
  end
end
