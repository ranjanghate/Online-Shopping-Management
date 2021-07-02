require 'rails_helper'

RSpec.describe "/courses", type: :request do
  course_credentials = { name: "maths", description: "this is a course about maths", price: 21 }
  
  describe "GET /index" do
    it "renders all courses page" do
      course = Course.new()
      get courses_url
      expect(response).to render_template("index")
    end
    it "assigns @courses to render" do
      course = Course.new(course_credentials)
      course.save
      get courses_url
      expect(assigns(:courses)).to eq([course])
    end
  end

  describe "GET /new" do
    describe "Create course with admin login" do
      it "will not renders a new course page" do
        get new_course_url
        expect(response).to redirect_to(courses_path)
      end
    end
  end

  describe "POST /create" do
    describe "Create a new course field in table" do
      it "will create a new course" do
        expect do
          course = Course.new(course_credentials)
          course.save
          post courses_url
        end.to change(Course, :count).by(1)
        expect(response).to redirect_to(courses_path)
      end
      it "will not create a new course" do
        expect do
          course = Course.new(course_credentials)
          course.description = "123"
          course.save
          post courses_url
        end.to change(Course, :count).by(0)
        expect(response).to redirect_to(courses_path)
      end
    end
  end

  describe "GET /show" do
    describe "render a course page" do
      it "will show course page" do
        course = Course.new(course_credentials)
        course.save
        get course_path(course)
        expect(response).to have_http_status(:ok)
      end
    end
  end

  describe "GET /edit" do
    describe "edit course with admin login" do
      it "will not renders a edit course page" do
        course = Course.new(course_credentials)
        course.save
        get edit_course_url(course)
        expect(response).to redirect_to(courses_path)
      end
    end
  end

  describe "PATCH /update" do
    describe "update course" do
      course = Course.new(course_credentials)
      course.save
      it "with valid credentials" do
        expect do
          course.description = "description is updated"
          patch course_url(course)
        end.to change(Course, :count).by(0)
      end
    end
    describe "update course" do
      course = Course.new(course_credentials)
      course.save
      it "with invalid credentials" do
        expect do
          course.description = "description"
          patch course_url(course)
        end.to change(Course, :count).by(0)
      end
    end
  end

  describe "DELETE /destroy" do
    describe " without admin login " do
      it "will not destroy the requested course" do
        course = Course.new(course_credentials)
        course.save
        expect do
          delete course_url(course)
        end.to change(Course, :count).by(0)
      end

      it "redirects to course list page" do
        course = Course.new(course_credentials)
        course.save
        delete course_url(course)
        expect(response).to redirect_to(courses_url)
      end
    end
  end
end
