module ApplicationHelper
  def is_home_page?
    controller.controller_name == "home"
  end

  def is_dashboard_page?
    controller.controller_name == "dashboard"
  end

  def is_dashboard_index_page?
    is_dashboard_page? && controller.action_name == "index"
  end

  def is_dashboard_students_page?
    is_dashboard_page? && controller.action_name == "students"
  end

  def is_dashboard_courses_page?
    (is_dashboard_page? && controller.action_name == "courses") \
      || controller.controller_name == "courses"
  end

  def is_dashboard_notifications_page?
    is_dashboard_page? && controller.action_name == "notifications"
  end

  def is_dashboard_messages_page?
    is_dashboard_page? && controller.action_name == "messages"
  end
end
