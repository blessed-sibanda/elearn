require "rails_helper"

RSpec.describe "Browsing Courses" do
  before :each do
    create_list :subject, 6
    50.times do
      subject = Subject.all.sample
      subject.courses << build(:course, :with_random_status)
    end
  end

  it "paginates courses" do
    visit root_path
    pages_count = (Course.published.count / Course.per_page) + 1
    within "nav.pagination" do
      (2..pages_count).each do |page_number|
        expect(page).to have_selector("a", text: page_number)
      end
    end

    page_num = 1
    while page_num < pages_count
      page_num += 1
      within "nav.pagination" do
        click_on "Next"
      end
      expect(current_path).to eq(root_path)
      Course.published.page(page_num).order(created_at: :desc).each do |c|
        expect(page).to have_content(c.title)
      end
    end
  end

  it "returns only published courses in descending order of creation date" do
    visit root_path
    Course.published.page(1).order(created_at: :desc).each do |c|
      expect(page).to have_content(c.title)
    end
  end
end
