require 'spec_helper'

feature 'Admin panel' do
  context "on admin homepage" do

    it "can see a list of recent posts" do
      post = Post.create(title: "test", content: "so testy", is_published: true)
      page.driver.browser.authorize 'geek', 'jock'
      visit admin_posts_url
      expect {
        response.body.should have_link("Test")
      }

    end

    it "can edit a post by clicking the edit link next to a post" do
      post = Post.create(title: "test", content: "so testy", is_published: true)
      page.driver.browser.authorize 'geek', 'jock'
      visit admin_posts_url
      expect {
        click_link("Edit")
        response.should redirect_to(edit_admin_post_url)
      }

    end

    it "can delete a post by clicking the delete link next to a post" do
      Post.create(title: "test1", content: "so testy1", is_published: true)
      page.driver.browser.authorize 'geek', 'jock'
      visit admin_posts_url

      expect {
        click_link("Delete")
       }.to change(Post, :count).by(-1)
    end


    it "can create a new post and view it" do
      post = Post.create(title: "test", content: "so testy", is_published: true)
      page.driver.browser.authorize 'geek', 'jock'
      visit new_admin_post_url

       expect {
         fill_in 'post_title',   with: "Hello world!"
         fill_in 'post_content', with: "Lorem ipsum dolor sit amet, consectetuer adipiscing elit, sed diam nonummy nibh euismod tincidunt ut laoreet dolore magna aliquam erat volutpat."
         page.check('post_is_published')
         click_button "Save"
       }.to change(Post, :count).by(1)

       expect(page).to have_content "Published: true"
       expect(page).to have_content "Post was successfully saved."
     end
  end

  context "editing post" do
    it "can mark an existing post as unpublished" do
      post = Post.create(title: "test", content: "so testy", is_published: true)
      page.driver.browser.authorize 'geek', 'jock'
      visit edit_admin_post_url(post)
      expect{
        page.uncheck('post_is_published')
        click_button "Save"
        response.body.should have_content "Published: false"
      }

    end
  end

  context "on post show page" do

    it "can visit a post show page by clicking the title" do
      post = Post.create(title: "test", content: "so testy", is_published: true)
      page.driver.browser.authorize 'geek', 'jock'
      visit ("admin/posts")

      click_link("#{post.title}")
      expect(page).to have_content("#{post.title}")
    end

    it "can see an edit link that takes you to the edit post path" do
      post = Post.create(title: "test", content: "so testy", is_published: true)
      page.driver.browser.authorize 'geek', 'jock'
      visit admin_post_url(post)

      expect{
        click_link("Edit")
        response.should redirect_to(edit_admin_post_url)
      }
    end

    it "can go to the admin homepage by clicking the Admin welcome page link" do
      post = Post.create(title: "test", content: "so testy", is_published: true)
      page.driver.browser.authorize 'geek', 'jock'
      visit admin_post_url(post)

      click_link("Admin welcome page")
      expect(page).to have_content("Welcome to the admin panel!")
    end
  end
end
