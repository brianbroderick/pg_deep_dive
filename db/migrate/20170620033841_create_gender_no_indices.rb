class CreateGenderNoIndices < ActiveRecord::Migration[5.0]
  create_table :gender_no_indices do |t|
    t.string :name, null: false, default: ""
    t.decimal :male, null: false, default: 0, precision: 8, scale: 6
    t.decimal :female, null: false, default: 0, precision: 8, scale: 6
    t.timestamps null: false
  end
end
