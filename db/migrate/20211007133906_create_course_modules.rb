class CreateCourseModules < ActiveRecord::Migration[6.1]
  def change
    create_table :course_modules do |t|
      t.references :course, null: false, foreign_key: true
      t.string :title
      t.text :description
      t.integer :order

      t.timestamps
    end
    add_index :course_modules, :title, unique: true
  end
end
