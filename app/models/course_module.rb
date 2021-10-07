# == Schema Information
#
# Table name: course_modules
#
#  id          :bigint           not null, primary key
#  description :text
#  order       :integer
#  title       :string
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
class CourseModule < ApplicationRecord
  belongs_to :course
  validates :title, :description, presence: true
  validates :title, uniqueness: true

  before_create do
    self.order = 1 + course.modules.pluck(:order).reject(&:nil?).max.to_i
  end
end
