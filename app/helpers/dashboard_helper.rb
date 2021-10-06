module DashboardHelper
  def metric(count, item, color: "primary", link: "#")
    item.capitalize!
    unless count == 1
      item = item.pluralize
    end
    render partial: "dashboard/metric",
           locals: { count: count, item: item, color: "is-#{color}", link: link }
  end

  def course_stats(title, courses)
    render partial: "dashboard/course_list",
           locals: { courses: courses, title: title }
  end
end
