class CreateConvergences < ActiveRecord::Migration
  def change
    create_table :convergences do |t|
      t.references :story, null: false
      t.references :parent, null: false
      t.references :child, null: false

      t.string :title, null: false

      t.timestamps null: false
    end
  end
end
