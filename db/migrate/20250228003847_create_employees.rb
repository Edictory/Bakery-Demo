class CreateEmployees < ActiveRecord::Migration[7.0]
  def change
    create_table :employees do |t|
      t.string :first_name, null: false
      t.string :last_name, null: false
      t.string :ssn, null: false
      t.date :date_hired, null: false
      t.date :date_terminated
      t.references :user, null: false, foreign_key: true
      t.boolean :active, default: true, null:  false

      t.timestamps
    end
  end
end
