require "rails_helper"

RSpec.describe CoursePolicy, type: :policy do
  let(:user) { build :user }
  let(:course) { build :course }

  subject { described_class }

  permissions :enroll? do
    context "user is course owner" do
      it "denies access" do
        expect(subject).not_to permit(course.owner, course)
      end
    end
    context "user is not course owner" do
      it "denies access if user is already enrolled" do
        course.students << user
        expect(subject).not_to permit(user, course)
      end
      it "grants access if user is not enrolled" do
        expect(subject).to permit(user, course)
      end
    end
  end

  permissions :manage? do
    it "denies access if user is not course owner" do
      expect(subject).not_to permit(user, course)
    end
    it "grants access if user is course owner" do
      expect(subject).to permit(course.owner, course)
    end
  end
end
