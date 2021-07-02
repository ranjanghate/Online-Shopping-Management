class CoursesController < ApplicationController
  before_action :authenticate_admin_user!, only: %i(new create edit update destroy)
  before_action :valid_course?, only: %i(show edit update destroy)

  def index
    @courses = Course.all
  end

  def new
    @course = Course.new
  end

  def create
    @course = Course.new(course_params)

    if @course.save
      ActionCable.server.broadcast('notification_channel', "Admin added a new course -> #{@course.name}")
      redirect_to courses_path, success: "New Course is added"
    else
      flash.now[:danger] = "Failed to add course"
      render :new
    end
  end

  def show; end

  def edit; end

  def update
    if @course.update(course_params)
      ActionCable.server.broadcast('notification_channel', "Admin updated a course -> #{@course.name}")
      redirect_to course_path(@course), success: "Course Updated successfully"  
    else
      render :edit
    end
  end

  def destroy
    ActionCable.server.broadcast('notification_channel', "Admin deleted a course -> #{@course.name}")
    @course.destroy
    redirect_to courses_path, success: "Course deleted successfully"
  end

  private

  def course_params
    params.require(:course).permit(:name, :description, :price, contents: [])
  end

  def valid_course?
    @course = Course.find_by(id: params[:id])
    redirect_to courses_path, warning: "You are trying to access invalid course" if @course.blank?
  end
end
