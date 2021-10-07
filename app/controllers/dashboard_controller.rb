class DashboardController < ApplicationController
  def index
  end

  def courses
    @courses = Course.by_status(params["status"])
      .where(owner: current_user)
      .page(params[:page]).order(created_at: :desc)
  end

  def students
  end

  def notifications
  end

  def messages
  end
end
