class CreateCourses < ActiveRecord::Migration[6.1]
  def change
    create_table :courses do |t|
      t.string :title, null: false
      t.string :slug, null: false
      t.references :subject, null: false, foreign_key: true
      t.text :overview, null: false
      t.bigint :owner_id, null: false

      t.timestamps
    end
    add_index :courses, :slug, unique: true
    add_foreign_key :courses, :users, column: :owner_id
  end
end
