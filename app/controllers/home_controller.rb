class HomeController < ApplicationController
  def index
    @subjects = Subject.with_courses.order("COUNT(courses.id) DESC")
    keywords = params[:keywords]
    field = params[:field] || "created_at"
    order = params[:order] || "desc"
    ordering = "#{field} #{order}"
    if keywords.nil?
      if slug = params[:subject]
        @subject = Subject.find_by(slug: slug)
        @courses = Course.published.where(subject: @subject).page(params["page"]).order(ordering)
      else
        @courses = Course.published.page(params["page"]).order(ordering)
      end
    else
      search_results = Course.search(keywords).published
    end

    respond_to do |format|
      format.js do
        if search_results
          @courses = Course.where(id: search_results.ids)
            .page(params["page"]).order(ordering)
        end
        render @courses
      end
      format.html do
        if search_results
          # dont apply ordering to search results
          # because the search already ranked them
          @courses = search_results.page(params["page"])
        end
      end
    end
  end
end
