class CreateSubjects < ActiveRecord::Migration[6.1]
  def change
    create_table :subjects do |t|
      t.string :title, null: false
      t.string :slug, null: false

      t.timestamps
    end
    add_index :subjects, :slug, unique: true
  end
end
