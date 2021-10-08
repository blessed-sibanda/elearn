# == Schema Information
#
# Table name: subjects
#
#  id         :bigint           not null, primary key
#  slug       :string           not null
#  title      :string           not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
# Indexes
#
#  index_subjects_on_slug  (slug) UNIQUE
#
require "rails_helper"

RSpec.describe Subject, type: :model do
  describe "associations" do
    it { should have_many(:courses) }
  end

  describe "validations" do
    subject { build(:subject) }
    it { should validate_presence_of(:title) }
    it { should validate_uniqueness_of(:title) }
    it { should validate_uniqueness_of(:slug) }
  end

  describe "before save" do
    it "should generate slug if slug is nil" do
      subject = build :subject
      expect(subject.slug).to be_nil
      subject.save
      expect(subject.slug).not_to be_nil
      expect(subject.slug).to eq(subject.title.parameterize)
    end

    it "should slug if slug is not nil" do
      subject = build :subject, slug: "subject-slug"
      subject.save
      expect(subject.slug).not_to eq(subject.title.parameterize)
      expect(subject.slug).to eq("subject-slug")
    end
  end

  describe "#with_courses scope" do
    it "should return only subjects with published courses" do
      s1 = create :subject
      s1.courses << create_list(:course, 3, :draft)

      s2 = create :subject
      s2.courses << create_list(:course, 4, :published)

      s3 = create :subject
      s3.courses << create_list(:course, 2, :draft)
      s3.courses << create_list(:course, 1, :published)

      s4 = create :subject

      expect(Subject.with_courses).to contain_exactly(s2, s3)
    end
  end
end
