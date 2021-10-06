class DashboardController < ApplicationController
  def index
    @active = "index"
  end

  def courses
    @active = "courses"
  end

  def students
    @active = "students"
  end

  def notifications
    @active = "notifications"
  end

  def messages
    @active = "messages"
  end
end
