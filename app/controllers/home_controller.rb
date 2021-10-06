class HomeController < ApplicationController
  def index
    @subjects = Subject.with_courses.order("COUNT(courses.id) DESC")
    if slug = params[:subject]
      @subject = Subject.find_by(slug: slug)
      @courses = Course.where(subject: @subject).page(params["page"])
    else
      @courses = Course.page(params["page"])
    end
  end
end
