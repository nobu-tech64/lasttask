class CreateProducts < ActiveRecord::Migration[5.0]
  def change
    create_table :products do |t|
      t.string :name, null: false
      t.text :description
      t.references :category, foreign_key: true
      t.integer :condition_id, null: false, limit:1
      t.integer :burden_id, null: false, limit:1
      t.integer :from_area_id, null: false, limit:1
      t.integer :delivery_days_id, null: false, limit:1
      t.integer :price, null: false
      t.references :brand, foreign_key: true
      t.references :user, foreign_key: true
      t.timestamps
    end
  end
end
