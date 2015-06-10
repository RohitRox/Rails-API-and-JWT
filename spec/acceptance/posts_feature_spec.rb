require 'rails_helper'
require 'rspec_api_documentation/dsl'

resource "Posts" do

  header "Accept", "application/json"
  header "Content-Type", "application/json"

  get "/api/posts" do

    before do
      2.times do
        create(:post)
      end
    end

    example "GET posts" do
      do_request
      expect(status).to eq 200
    end
  end

  post "api/posts" do
    parameter :title, "Post title", required: true, scope: :post
    parameter :content, "Post Content", required: false, scope: :post

    context "Blank title" do

      let(:title) { "" }
      let(:content) { "" }

      example "Create a new post with blank title" do
        do_request
        expect(status).to eq 422
      end
    end

    context "With title" do
      let(:title) { "My Title" }
      let(:content) { "Some long long awesome content." }

      example "Create a new post with title and content" do
        do_request
        expect(status).to eq 201
      end
    end

  end
end