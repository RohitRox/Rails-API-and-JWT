require 'rails_helper'
require 'rspec_api_documentation/dsl'

resource "Posts" do

  header "Accept", "application/json"
  header "Content-Type", "application/json"

  get "/api/posts" do

    parameter :per_page, "Per Page", required: true, default: Kaminari::config.default_per_page, scope: :post
    parameter :page, "Page", required: false, default: 1, scope: :post
    parameter :sort, "Sort Column", required: false, default: "created_at", scope: :post
    parameter :odrer, "Sort Order", required: false, default: "desc", scope: :post

    before do
      2.times do
        create(:post)
      end
    end

    example "Get posts" do
      do_request
      expect(status).to eq 200
    end
  end

  post "api/posts" do
    parameter :title, "Post Title", required: true, scope: :post
    parameter :content, "Post Content(Min 25 chars)", required: true, scope: :post

    context "Invalid params" do

      let(:title) { "" }
      let(:content) { "" }

      example "Create a new post with invalid title" do
        do_request
        expect(status).to eq 200
      end
    end

    context "With valid params" do
      let(:title) { "My Title" }
      let(:content) { "Some long long awesome content." }

      example "Create a new post with valid params" do
        do_request
        expect(status).to eq 200
      end
    end
  end

  put "/api/posts/:id" do
    parameter :title, "Post Title", required: true, scope: :post
    parameter :content, "Post Content(Min 25 chars)", required: true, scope: :post

    let(:post){ create(:post) }
    let(:id) { post.id }

    context "Invalid params" do

      let(:title) { "" }
      let(:content) { "" }

      example "Update a new post with invalid params" do
        do_request
        expect(status).to eq 200
      end
    end

    context "With valid params" do
      let(:title) { "My New Title" }
      let(:content) { "Some long long awesome content." }

      example "Update a post with valid params" do
        do_request
        expect(status).to eq 200
      end
    end
  end

  delete "/api/posts/:id" do
    let(:post){ create(:post) }
    let(:id) { post.id }

    example "Delete a post" do
      do_request
      expect(status).to eq 200
    end

  end

end
