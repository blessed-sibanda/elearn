class HomeController < ApplicationController
  def index
    @subjects = Subject.with_courses.order("COUNT(courses.id) DESC")
    keywords = params[:keywords]
    if keywords.nil?
      if slug = params[:subject]
        @subject = Subject.find_by(slug: slug)
        @courses = Course.published.where(subject: @subject).page(params["page"])
      else
        @courses = Course.published.page(params["page"])
      end
    else
      @courses = Course.search(keywords).published.page(params["page"])
    end
  end
end
