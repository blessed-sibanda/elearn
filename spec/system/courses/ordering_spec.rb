require "rails_helper"

RSpec.describe "Ordering Courses" do
  def create_courses
    create_list :subject, 3
    rand(5..10).times do
      create :course, price: rand(0..30), status: "Published", subject: Subject.all.sample
    end
  end

  before(:each) do
    create_courses
  end

  it "can order courses by date in descending order", js: true do
    visit root_path
    select "Date", from: "field"
    select "Desc", from: "order"

    courses = Course.page(1).published.order("created_at desc")

    sleep 0.1
    expect(find("#courses").first(".card h3.title").text).to eq(courses.first.title)
    expect(find_all("#courses > .card h3.title").last.text).to eq(courses.last.title)
  end
  it "can order courses by date in ascending order", js: true do
    visit root_path
    select "Date", from: "field"
    select "Asc", from: "order"

    courses = Course.page(1).published.order("created_at asc")
    sleep 0.1
    expect(find("#courses").first(".card h3.title").text).to eq(courses.first.title)
    expect(find_all("#courses > .card h3.title").last.text).to eq(courses.last.title)
  end
  it "can order courses by price in descending order", js: true do
    visit root_path
    select "Price", from: "field"

    courses = Course.page(1).published.order("price desc")

    sleep 0.1
    expect(find("#courses").first(".card h3.title").text).to eq(courses.first.title)
    expect(find_all("#courses > .card h3.title").last.text).to eq(courses.last.title)
  end
  it "can order courses by price in ascending order", js: true do
    visit root_path
    select "Price", from: "field"
    select "Asc", from: "order"

    courses = Course.page(1).published.order("price asc")

    sleep 0.1
    expect(find("#courses").first(".card h3.title").text).to eq(courses.first.title)
    expect(find_all("#courses > .card h3.title").last.text).to eq(courses.last.title)
  end
end
