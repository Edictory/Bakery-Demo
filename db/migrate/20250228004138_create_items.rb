class CreateItems < ActiveRecord::Migration[7.0]
  def change
    create_table :items do |t|
      t.string :name, null: false
      t.text :description
      t.integer :category, null: false
      t.integer :units_per_item, null: false
      t.float :weight, null: false
      t.boolean :active, default: true, null: false

      t.timestamps
    end
  end
end
