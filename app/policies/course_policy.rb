class CoursePolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      scope.all
    end
  end

  def manage?
    record.owner == user
  end

  def enroll?
    if record.owner == user || record.students.include?(user)
      false
    else
      true
    end
  end
end
