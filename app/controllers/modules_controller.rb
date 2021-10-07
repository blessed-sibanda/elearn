class ModulesController < ApplicationController
  before_action :set_course
  before_action :set_module, except: [:new, :create]
  before_action :verify_authorized, except: [:show, :new, :create]

  def new
    authorize @course, :manage?, policy_class: CoursePolicy
    @module = CourseModule.new
  end

  def create
    authorize @course, :manage?, policy_class: CoursePolicy
    @module = CourseModule.new(course_module_params)
    @module.course = @course
    if @module.save
      redirect_to @course, notice: "Course Module created successfully"
    else
      render :new
    end
  end

  def show
    authorize @module
  end

  def edit
  end

  def update
    if @module.update(course_module_params)
      redirect_to course_module_path(@module.course, @module), notice: "Module updated successfully"
    else
      render :edit
    end
  end

  private

  def set_course
    @course = Course.find_by(slug: params[:course_slug])
  end

  def set_module
    @module = CourseModule.find(params[:id])
  end

  def course_module_params
    params.require(:course_module).permit(:title, :description, :content, :video_url)
  end

  def verify_authorized
    authorize @module, :manage?
  end
end
