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
FactoryBot.define do
  factory :course_module do
    course { nil }
    title { "MyString" }
    description { "MyText" }
    order { 1 }
  end
end
