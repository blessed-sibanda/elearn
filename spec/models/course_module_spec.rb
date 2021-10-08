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
require "rails_helper"

RSpec.describe CourseModule, type: :model do
  describe "associations" do
    it { should belong_to(:course) }
    it { should have_rich_text(:content) }
  end

  describe "validations" do
    subject { build(:course_module) }
    it { should validate_presence_of(:title) }
    it { should validate_presence_of(:description) }
    it { should validate_uniqueness_of(:title) }
  end

  describe "before create" do
    it "sets the order column to the value just after the max order for modules in the same course" do
      c1 = create :course
      c2 = create :course

      cm1 = create :course_module, course: c1
      cm2 = create :course_module, course: c1
      cm3 = create :course_module, course: c2
      cm4 = create :course_module, course: c1
      cm5 = create :course_module, course: c2

      expect(cm1.order).to eq(1)
      expect(cm2.order).to eq(2)
      expect(cm3.order).to eq(1)
      expect(cm4.order).to eq(3)
      expect(cm5.order).to eq(2)
    end
  end
end
