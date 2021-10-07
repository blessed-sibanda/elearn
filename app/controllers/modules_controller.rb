class ModulesController < ApplicationController
  before_action :set_course, only: [:index, :edit, :new, :create, :show]
  before_action :set_module, only: [:edit, :update, :show, :destroy]

  def new
    @module = CourseModule.new
  end

  def create
    @module = CourseModule.new(course_module_params)
    @module.course = @course
    if @module.save
      redirect_to @course, notice: "Course Module created successfully"
    else
      render :new
    end
  end

  def show
  end

  def edit
  end

  private

  def set_course
    @course = Course.find_by(slug: params[:course_slug])
  end

  def set_module
    @module = CourseModule.find(params[:id])
  end

  def course_module_params
    params.require(:course_module).permit(:title, :description, :content)
  end
end
