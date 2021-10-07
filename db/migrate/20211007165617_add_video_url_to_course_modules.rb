class AddVideoUrlToCourseModules < ActiveRecord::Migration[6.1]
  def change
    add_column :course_modules, :video_url, :string, null: true
  end
end
