class CoursesController < ApplicationController
  layout "dashboard"

  def new
    @course = Course.new
  end

  def create
    @course = current_user.courses.build(course_params)
    if @course.save
      redirect_to dashboard_courses_url, notice: "Course created successfully"
    else
      render :new
    end
  end

  private

  def course_params
    params.require(:course).permit(:title, :subject_id, :overview)
  end
end
