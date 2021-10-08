require "rails_helper"

RSpec.describe "Searching Courses" do
  def search_for(term)
    visit root_path
    fill_in "keywords", with: term
    click_button "Search"
  end

  it "can search for courses" do
    c1 = create :course, title: "Professional Django", overview: "The comprehensive guide", status: "Published"
    c2 = create :course, title: "Comprehensive Rails 6", overview: "a complete guide", status: "Published"
    c3 = create :course, title: "Django for Beginners", overview: "an excellent django tutorial", status: "Published"

    search_for("Django")
    expect(current_path).to eq(root_path)
    expect(page).to have_content(c1.title)
    expect(page).not_to have_content(c2.title)
    expect(page).to have_content(c3.title)

    search_for("Rails")
    expect(current_path).to eq(root_path)
    expect(page).not_to have_content(c1.title)
    expect(page).to have_content(c2.title)
    expect(page).not_to have_content(c3.title)

    search_for("djan")
    expect(page).to have_content(c1.title)
    expect(page).not_to have_content(c2.title)
    expect(page).to have_content(c3.title)

    search_for("tut")
    expect(page).not_to have_content(c1.title)
    expect(page).not_to have_content(c2.title)
    expect(page).to have_content(c3.title)

    search_for("Comprehensive guide")
    expect(page).to have_content(c1.title)
    expect(page).to have_content(c2.title)
    expect(page).not_to have_content(c3.title)
  end
end
