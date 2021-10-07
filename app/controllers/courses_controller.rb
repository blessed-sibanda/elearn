class CoursesController < ApplicationController
  layout "dashboard"
  before_action :set_course, only: [:edit, :update, :destroy, :show]
  before_action :verify_authorized, only: [:edit, :update, :destroy]

  def show
    render layout: "application"
  end

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

  def edit
  end

  def update
    if @course.update(course_params)
      redirect_to dashboard_courses_url, notice: "Course updated successfully"
    else
      render :edit
    end
  end

  def destroy
    @course.destroy
    redirect_to dashboard_courses_url, notice: "Course deleted successfully"
  end

  private

  def course_params
    params.require(:course).permit(:title, :subject_id, :overview, :status, :price)
  end

  def set_course
    @course = Course.find_by_slug(params[:slug])
  end

  def verify_authorized
    authorize @course, :manage?
  end
end
