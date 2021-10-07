module CoursesHelper
  def course_price(course)
    render "courses/price", course: course
  end
end
