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
FactoryBot.define do
  factory :course_module do
    title { Faker::Lorem.paragraph + SecureRandom.hex(3) }
    description { Faker::Lorem.paragraphs.join }
    association :course, strategy: :build
  end
end
