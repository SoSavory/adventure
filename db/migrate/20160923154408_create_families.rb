class CreateFamilies < ActiveRecord::Migration
  def change
    create_table :families do |t|
      t.string :name
      t.references :admin
      t.boolean :private
      t.timestamps null: false
    end
  end
end
