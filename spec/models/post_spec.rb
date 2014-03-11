require 'spec_helper'

describe Post do
  it "title should be automatically titleized before save" do
    pending
  end

  it "post should be unpublished by default" do
    expect(Post.new.is_published).to be_false
  end

  # a slug is an automaticaly generated url-friendly
  # version of the title
  it "slug should be automatically generated" do
    post = Post.new(title: "New post!", content: "A great story")

    expect(post.slug).to be_nil
    post.save

    expect(post.slug).to eq "new-post"
  end
end
