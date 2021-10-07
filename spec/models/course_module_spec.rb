# == Schema Information
#
# Table name: course_modules
#
#  id          :bigint           not null, primary key
#  description :text
#  order       :integer
#  title       :string
#  video_url   :string
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  course_id   :bigint           not null
#
# Indexes
#
#  index_course_modules_on_course_id  (course_id)
#  index_course_modules_on_title      (title) UNIQUE
#
# Foreign Keys
#
#  fk_rails_...  (course_id => courses.id)
#
require 'rails_helper'

RSpec.describe CourseModule, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
end
