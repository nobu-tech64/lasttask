class CreateProfiles < ActiveRecord::Migration[5.0]
  def change
    create_table :profiles do |t|
      t.string :first_name, null: false
      t.string :last_name, null: false
      t.string :first_name_ruby, null: false
      t.string :last_name_ruby, null: false
      t.integer :birthyear, null: false
      t.integer :birthmonth, null: false
      t.integer :birthday, null: false
      t.timestamps
    end
  end
end
