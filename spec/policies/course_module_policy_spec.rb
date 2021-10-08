require "rails_helper"

RSpec.describe CourseModulePolicy, type: :policy do
  let(:user) { build :user }
  let(:cm) { build :course_module }

  subject { described_class }

  permissions :show? do
    context "user is module course owner" do
      it "grants access" do
        expect(subject).to permit(cm.course.owner, cm)
      end
    end
    context "user is not module course owner" do
      it "grants access if user is enrolled to module course" do
        cm.course.students << user
        expect(subject).to permit(user, cm)
      end
      it "denies access if user is not enrolled to module course" do
        expect(subject).not_to permit(user, cm)
      end
    end
  end

  permissions :manage? do
    it "denies access if user is not module course owner" do
      expect(subject).not_to permit(user, cm)
    end
    it "grants access if user is module course owner" do
      expect(subject).to permit(cm.course.owner, cm)
    end
  end
end
