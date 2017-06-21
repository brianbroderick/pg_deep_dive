class CreateGenders < ActiveRecord::Migration[5.0]
  create_table :genders do |t|
    t.string :name, null: false, default: "", index: true
    t.decimal :male, null: false, default: 0, precision: 8, scale: 6, index: true
    t.decimal :female, null: false, default: 0, precision: 8, scale: 6, index: true
    t.timestamps null: false
  end  
end
