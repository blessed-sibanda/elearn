class DashboardController < ApplicationController
  def index
  end

  def courses
    @courses = Course.where(owner: current_user).page(params[:page])
  end

  def students
  end

  def notifications
  end

  def messages
  end
end
