class CourseModulePolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      scope.all
    end
  end

  def manage?
    record.course.owner == user
  end
end
