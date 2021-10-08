# == Schema Information
#
# Table name: courses
#
#  id         :bigint           not null, primary key
#  overview   :text             not null
#  price      :decimal(8, 2)    default(0.0)
#  slug       :string           not null
#  status     :integer          default("Draft"), not null
#  title      :string           not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  owner_id   :bigint           not null
#  subject_id :bigint           not null
#
# Indexes
#
#  index_courses_on_slug        (slug) UNIQUE
#  index_courses_on_subject_id  (subject_id)
#
# Foreign Keys
#
#  fk_rails_...  (owner_id => users.id)
#  fk_rails_...  (subject_id => subjects.id)
#
require "rails_helper"

RSpec.describe Course, type: :model do
  describe "associations" do
    it { should belong_to(:subject) }
    it { should belong_to(:owner).class_name("User") }
    it { should have_many(:modules).class_name("CourseModule") }
    it { should have_many(:enrollments) }
    it { should have_many(:students).through(:enrollments) }
  end

  describe "validations" do
    subject { build(:course) }
    it { should validate_presence_of(:title) }
    it { should validate_presence_of(:overview) }
    it { should validate_uniqueness_of(:title) }
    it { should validate_uniqueness_of(:slug) }
    it do
      should validate_numericality_of(:price).
               is_greater_than_or_equal_to(0)
    end
    it { should allow_value("Draft").for(:status) }
    it { should allow_value("Published").for(:status) }
  end

  describe "#to_param" do
    it "should return the course slug" do
      course = create :course
      expect(course.to_param).to eq(course.slug)
    end
  end

  describe "#is_draft?" do
    it "should return true if the course is in draft mode" do
      course = build :course
      expect(course.is_draft?).to be_truthy
    end
    it "should return false if the course is published" do
      course = build :course, status: "Published"
      expect(course.is_draft?).to be_falsy
    end
  end

  describe "before save" do
    it "should generate course slug if slug is nil" do
      course = build :course
      expect(course.slug).to be_nil
      course.save
      expect(course.slug).not_to be_nil
      expect(course.slug).to eq(course.title.parameterize)
    end

    it "should not generate course slug if slug is not nil" do
      course = build :course, slug: "course-slug"
      course.save
      expect(course.slug).not_to eq(course.title.parameterize)
      expect(course.slug).to eq("course-slug")
    end
  end

  describe "#published scope" do
    it "should return published courses only" do
      create_list :course, 10, :with_random_status
      Course.published.each do |c|
        expect(c.status).to eq("Published")
      end
    end
  end

  describe "#by_status scope" do
    before(:each) { create_list :course, 10, :with_random_status }
    context "valid status is provided" do
      it "should return filter courses by status" do
        Course.by_status("Draft").each do |c|
          expect(c.status).to eq("Draft")
        end
        Course.by_status("Published").each do |c|
          expect(c.status).to eq("Published")
        end
      end
    end

    context "invalid status is provided" do
      it "should return all courses" do
        expect(Course.by_status(SecureRandom.hex(4)).count).to eq(Course.count)
      end
    end

    context "status is not provided" do
      it "should return all courses" do
        expect(Course.by_status.count).to eq(Course.count)
      end
    end
  end

  describe "search" do
    let(:c1) {
      create :course, title: "Professional Django",
                      overview: "The comprehensive guide"
    }
    let(:c2) {
      create :course, title: "Comprehensive Rails 6",
                      overview: "a complete guide"
    }
    let(:c3) {
      create :course, title: "Django for Beginners",
                      overview: "an excellent django tutorial"
    }

    it "should search for courses by title" do
      expect(Course.search("Django")).to contain_exactly(c1, c3)
      expect(Course.search("Rails")).to contain_exactly(c2)
      expect(Course.search("Lorem").any?).to be_falsy
    end

    it "should allow partial prefix matches" do
      expect(Course.search("djan")).to contain_exactly(c1, c3)
      expect(Course.search("tuto")).to contain_exactly(c3)
    end

    it "should also search courses by overview" do
      expect(Course.search("guide")).to contain_exactly(c1, c2)
      expect(Course.search("tutorial")).to contain_exactly(c3)
    end

    it "should rank search results by number of matches in both title and overview" do
      matches = Course.search("django")
      expect(matches).to contain_exactly(c1, c3)
      expect(matches.first).to eq(c3)
    end

    it "should rank title matches higher that overview matches" do
      matches = Course.search("Comprehensive guide")
      expect(matches).to contain_exactly(c1, c2)
      expect(matches.first).to eq(c2)
    end
  end
end
