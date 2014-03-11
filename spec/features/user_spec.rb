require 'spec_helper'

feature 'User browsing the website' do
  context "on homepage" do

    it "sees a list of recent posts titles" do
      Post.create(title: "test", content: "so testy", is_published: true)
      visit posts_url
      expect(page).to have_link("Test")
    end

    it "can click on titles of recent posts and should be on the post show page" do
      Post.create(title: "test", content: "so testy", is_published: true)
      visit posts_url
      click_link("Test")
      expect(page).to have_content("so testy")
    end
  end

  context "post show page" do
    it "sees title and body of the post" do
      post = Post.create(title: "test", content: "so testy", is_published: true)

      visit posts_url(post)
      expect(page).to have_content("Test")
      expect(page).to have_content("so testy")
    end
  end
end
