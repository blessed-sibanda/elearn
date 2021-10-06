class HomeController < ApplicationController
  def index
    @subjects = Subject.all
    if slug = params[:subject]
      @subject = Subject.find_by(slug: slug)
      @courses = Course.where(subject: @subject)
    else
      @courses = Course.all
    end
  end
end
