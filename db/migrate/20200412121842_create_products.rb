class CreateProducts < ActiveRecord::Migration[5.0]
  def change
    create_table :products do |t|
      t.string :name, null: false
      t.text :description, null: false
      t.string :condition_id, null: false
      t.string :burden_id, null: false
      t.string :from_area_id, null: false
      t.string :delivery_days_id, null: false
      t.integer :price, null: false
      t.references :brand, index: true, foreign_key: true
      t.timestamps
    end
    add_index :products, :name, unique: true
  end
end
