class CourseModulePolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      scope.all
    end
  end

  def show?
    record.course.students.include?(user) || record.course.owner == user
  end

  def manage?
    record.course.owner == user
  end
end
